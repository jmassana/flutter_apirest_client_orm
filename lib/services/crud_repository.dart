

import 'package:api_rest_client/services/api_manager.dart';
import 'package:api_rest_client/services/response_models/paged_result_model.dart';
import 'package:api_rest_client/services/response_models/response_result_model.dart';
import 'package:dio/dio.dart';


class CrudRepository<T>  {

  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  final String entryPoint;


  CrudRepository({required this.fromJson,required this.toJson,required this.entryPoint});

  Future<ResponseResult<PagedResult<T>>> get(
      {page = 0, pageLimit = 20, String? extraParams}) async {

    Response<dynamic> response = Response(data: {}, requestOptions: RequestOptions(path: ""));

    try {

      try {
        response = await ApiManager().makeGetRequest(
            "$kDomain$entryPoint/?page=${((page ?? 0) + 1)}&limit=$pageLimit${extraParams != null
                ? "&$extraParams"
                : ""}");
      } catch (e) {
        return ResponseResult(success: false, message: 'Failed to get ');
      }

      var statusCode = response.statusCode ?? 400;

      if (statusCode >= 200 && statusCode < 300) {
        var responseJson = response.data;

        var responseJsonResults = responseJson["results"];

        try {
          List<T> elements = (responseJsonResults as List)
              .map((element) => fromJson(element))
              .toList();

          var pagedResult = PagedResult<T>(
              count: responseJson["count"],
              next: responseJson["next"],
              previous: responseJson["previous"],
              results: elements);

          return ResponseResult(success: true, data: pagedResult);
        }catch(e,stacktrace){
          return ResponseResult(success: false, message: 'Failed to load configurations');
        }
      } else {
        return ResponseResult(success: false, message: 'Failed to load configurations');
      }
    } catch (e,stacktrace) {
      return ResponseResult(success: false, message: 'Failed to load configurations');
    }
  }

  Future<ResponseResult<T>> getDetail({String? id}) async {
    Response<dynamic> response;
    try {
      response = await ApiManager().makeGetRequest("$kDomain$entryPoint/$id/");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = response.data;
        return ResponseResult(success: true, data: fromJson(responseJson));
      } else {
        return ResponseResult(success: false, message: 'Failed to load object');
      }
    } catch (e) {
      return ResponseResult(success: false, message: 'Failed to load object');
    }
  }

  Future<ResponseResult<T>> add(T newElement) async {
    var elementToPost = toJson(newElement);


    Response<dynamic> response;
    try {
      response = await ApiManager().makePostRequest("$kDomain$entryPoint/", elementToPost);
      if (response.statusCode == 201) {
        Map<String, dynamic> responseJson = response.data;
        return ResponseResult(success: true, data: fromJson(responseJson));
      } else {
        return ResponseResult(success: false, message: 'Failed to add object');
      }
    } catch (e) {
      return ResponseResult(success: false, message: 'Failed to add object');
    }
  }





  Future<ResponseResult<T>> update(updatedConfigurationJson, uuid) async {
    Response<dynamic> response;
    try {
      response = await ApiManager()
          .makePatchRequest("$kDomain$entryPoint/$uuid/", toJson(updatedConfigurationJson));


      if (response.statusCode == 200) {
        return ResponseResult(success: true,data: fromJson(response.data));
      } else {
        return ResponseResult(success: false, message: 'Failed to update object');
      }
    } catch (e) {
      return ResponseResult(success: false, message: 'Failed to update object');
    }
  }



  Future<ResponseResult<T>> delete(String uuid) async {
    //DELETE ICON

    Response<dynamic> response;
    try {
      response =
      await ApiManager().makeDeleteRequest("$kDomain$entryPoint/$uuid");
      if (response.statusCode == 204) {
        return ResponseResult(success: true);
      } else {
        return ResponseResult(success: false, message: 'Failed to delete configuration');
      }
    } catch (e) {
      return ResponseResult(success: false, message: 'Failed to delete configuration');
    }
  }



}

import 'dart:convert';
import 'package:dio/dio.dart';



const kDomain = "https://testapi.com/api/";


class ApiManager {
  Dio dio = Dio();
  ApiManager();

  Dio get client {
    //ADD LOGIN HERE FOR INTERCEPTORS ALSO FOR ERROR HANDLING IF APPLIES

    return dio;
  }

  Future<Response> makeGetRequest(url) async {
    try {
      var response = await client.get(
        url,
      );
      return response;
    } catch (e) {


      rethrow;
    }
  }

  Future<Response> makePostRequest(url, newData) async {
    try {
      var response = await client.post(
        url,
        data: newData,
      );
      return response;
    } catch (e,stack) {
      rethrow;
    }
  }



  Future<Response> makePatchRequest(url, updatedData) async {
    try {
      var response = await client.patch(
        url,
        data: updatedData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> makeDeleteRequest(url) async {
    try {
      var response = await client.delete(
        url,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }





}



import 'package:api_rest_client/services/crud_repository.dart';

import '../response_models/paged_result_model.dart';

abstract class ORM<T> {

  String? uuid;
  CrudRepository? repo;

  ORM({this.uuid});

  void initializeRepository();


  Future<T> save() async {

    var response = await repo?.add(this);

    if(response!.success){
      return response.data;
    }else{

      throw Exception("Error saving object");
    }
  }

  Future<T> get() async {
    var response = await repo?.getDetail(id:uuid!);

    if(response!.success){
      return response.data;
    }else{
      throw Exception("Error getting detail object");
    }
  }

  Future<PagedResult<T>> list({int page = 0, int limit = 1000,String? extraParams }) async {

    var response = await repo?.get(pageLimit: limit,page: page, extraParams: extraParams);


    if(response != null  && response.success){
      return response.data as PagedResult<T>;
    }else{
      throw Exception("Error listing objects");
    }
  }



  Future<T> update() async {
    var response = await repo!.update(this,uuid!);

    if(response.success){
      return response.data;
    }else{
      throw Exception("Error updating object");
    }
  }

  Future<bool> delete() async {
    var response = await repo!.delete(this.uuid!);

    if(response.success){
      return response.success;
    }else{
      throw Exception("Error deleting object");
    }
  }



}
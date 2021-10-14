import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cubit_1/domain/user/model/user_detail_response.dart';
import 'package:flutter_cubit_1/domain/user/model/user_list_response.dart';

class UserRepository {
  Dio _dio = new Dio();

  Future<Either<String, UserList>> getUserSkills() async {
    Response _response;

    try {
      _response =
          await _dio.get('https://reqres.in/api/users?page=1&per_page=20');

      UserList _getUserList = UserList.fromJson(_response.data);
      return right(_getUserList);
    } on DioError catch (e) {
      // Error from Dio

      print("Status Code: ${e.response!.statusCode}");
      String errorMessage = e.response!.data.toString();
      switch (e.type) {
        case DioErrorType.connectTimeout:
          break;
        case DioErrorType.sendTimeout:
          break;
        case DioErrorType.receiveTimeout:
          break;
        case DioErrorType.response:
          errorMessage = e.response!.data["error"];
          break;
        case DioErrorType.cancel:
          break;
        case DioErrorType.other:
          break;
      }
      return left(errorMessage);
    }
  }

  Future<Either<String, UserDetailResponse>> getUserDetail(
      {@required int? id}) async {
    Response _response;

    try {
      _response = await _dio.get('https://reqres.in/api/users/$id');

      UserDetailResponse _getUserList =
          UserDetailResponse.fromJson(_response.data);
      return right(_getUserList);
    } on DioError catch (e) {
      // Error from Dio

      print("Status Code: ${e.response!.statusCode}");
      String errorMessage = e.response!.data.toString();
      switch (e.type) {
        case DioErrorType.connectTimeout:
          break;
        case DioErrorType.sendTimeout:
          break;
        case DioErrorType.receiveTimeout:
          break;
        case DioErrorType.response:
          errorMessage = e.response!.data["error"];
          break;
        case DioErrorType.cancel:
          break;
        case DioErrorType.other:
          break;
      }
      return left(errorMessage);
    }
  }
}

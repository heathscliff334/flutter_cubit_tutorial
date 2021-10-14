import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cubit_1/domain/auth/model/login_request.dart';
import 'package:flutter_cubit_1/domain/auth/model/login_response.dart';

class AuthRepository {
  Dio _dio = Dio();

  // ? pakai future untuk menspesifikkan data apa yang ingin diambil
  // ? Or using Either<> from Dartz
  // ! Either<L, R> L (Left) = wrong, R (Right) = right
  Future<Either<String, LoginResponse>> signInUserWithEmailAndPassword(
      {@required LoginRequest? loginRequest}) async {
    Response _response;
    // ! you can use try catch to handling an error
    try {
      _response =
          await _dio.post('https://reqres.in/api/login', data: loginRequest);

      LoginResponse? _loginResp = LoginResponse.fromJson(_response.data);
      return right(_loginResp);
    } on DioError catch (e) {
      // Error from Dio
      print(e.response!.statusCode);
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

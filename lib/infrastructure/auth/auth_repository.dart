import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  Dio _dio = Dio();

  // ? pakai future untuk menspesifikkan data apa yang ingin diambil
  Future<String?> signInUserWithEmailAndPassword({
    @required String? email,
    @required String? password,
  }) async {
    Response _response;
    // Map data type is json type (key:value)
    Map<String, dynamic> requestData = {
      "email": email,
      "password": password,
    };
    // ? the data type from post is dynamic
    _response =
        await _dio.post('https://reqres.in/api/login', data: requestData);
    // ? Set / fill data from _response to _result and then return _result
    String _result = _response.data.toString();
    return _result;
  }
}

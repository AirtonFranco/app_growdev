import 'dart:convert';

import 'package:app_growdev/models/user_model.dart';
import 'package:dio/dio.dart';

class Api {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api-cards-growdev.herokuapp.com',
  ));

  Future? fazerLogin(UserModel user) async {
    var params = {"email": "${user.email}", "password": "${user.senha}"};

    try {
      var response = await dio.post('/login', data: json.encode(params));
      print('API ${response.data}');
      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }

  Future? fazerCadastro(UserModel user) async {
    var params = {
      "name": "${user.nome}",
      "email": "${user.email}",
      "password": "${user.senha}"
    };

    print(params);
    print(json.encode(params));
    try {
      var response = await dio.post('/users', data: json.encode(params));
      print('API ${response.data}');
      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }
}

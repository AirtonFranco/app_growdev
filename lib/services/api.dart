import 'dart:convert';
import 'package:app_growdev/models/card_model.dart';
import 'package:dio/dio.dart';
import 'package:app_growdev/controllers/login_controller.dart';
import 'package:app_growdev/models/user_model.dart';

class Api {
  late UserModel? user;
  late String? token;

  Api({
    this.user,
    this.token,
  });

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api-cards-growdev.herokuapp.com',
    ),
  );

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'token': token,
    };
  }

  factory Api.fromMap(Map<String, dynamic> map) {
    return Api(
      user: UserModel.fromMap(map['user']),
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Api.fromJson(String source) => Api.fromMap(json.decode(source));

  //================================================================================//
  //================= LOGIN / CADASTRO / GET / POST / PUT / DELETE =================//
  //================================================================================//

  Future? fazerLogin(UserModel user) async {
    var params = {"email": "${user.email}", "password": "${user.password}"};

    try {
      var response = await dio.post('/login', data: json.encode(params));
      print('API ${response.data}');
      token = Api.fromMap(response.data).token;
      print(token);
      print(user);
      return response;
    } on DioError catch (e) {
      print('API - FazerLogin ERRO: ${e.response}');
    }
  }

  Future? fazerCadastro(UserModel user) async {
    var params = {
      "name": "${user.name}",
      "email": "${user.email}",
      "password": "${user.password}"
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

  Future? buscarTodosCards() async {
    print("BUSCANDO TODOS OS CARDS");
    try {
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.get(
        '/cards',
      );

      print(response.data);
      return response;
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }

  Future? buscarCardId(int id) async {
    print('BUSCANDO CARD');
    dio.options.headers["Authorization"] = "Bearer ${token}";
    try {
      var response = await dio.get('/cards/$id');
      print(response.data);
      return response;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future? criarCard(CardModel card) async {
    print('CRIANDO CARD');
    dio.options.headers["Authorization"] = "Bearer ${token}";
    try {
      var response = await dio.post(
        '/cards',
        data: card.toJson(),
      );
      print(response.data);
      return response;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future? editarCard(CardModel card) async {
    print('ATUALIZANDO CARD');
    dio.options.headers["Authorization"] = "Bearer ${token}";
    try {
      var response = await dio.put(
        '/cards/${card.id}',
        data: CardModel(title: card.title, content: card.content).toJson(),
      );
      print(response.data);
      return response;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future? deletarCard(int id) async {
    print('DELETANDO CARD');
    dio.options.headers["Authorization"] = "Bearer ${token}";
    try {
      var response = await dio.delete('/cards/$id');
      print(response.data);
      return response;
    } on DioError catch (e) {
      print(e);
    }
  }
}

import 'package:app_growdev/models/card_model.dart';
import 'package:app_growdev/services/api.dart';
import 'package:dio/dio.dart';

class HomeController {
  Future? buscarTodosCards(String token) async {
    Response response = await Api(token: token).buscarTodosCards();
  }
}

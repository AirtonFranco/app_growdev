import 'package:app_growdev/models/card_model.dart';
import 'package:app_growdev/services/api.dart';
import 'package:dio/dio.dart';

class HomeController {
  Future<List<CardModel>> buscarTodosCards(String token) async {
    Response response = await Api(token: token).buscarTodosCards();
    List<CardModel> list =
        (response.data as List).map((e) => CardModel.fromMap(e)).toList();

    return list;
  }

  Future<bool> deletarCard(String token, int id) async {
    Response response = await Api(token: token).deletarCard(id);
    if (response.statusCode == 200) return true;
    return false;
  }
}

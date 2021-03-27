import 'package:app_growdev/models/card_model.dart';
import 'package:app_growdev/services/api.dart';
import 'package:dio/dio.dart';

class CardController {
  Future<bool> criarCard(String token, String title, String content) async {
    Response response = await Api(token: token)
        .criarCard(CardModel(title: title, content: content));
    if (response.statusCode == 200) return true;
    return false;
  }
}

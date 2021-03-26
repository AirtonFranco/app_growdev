import 'package:app_growdev/models/card_model.dart';
import 'package:app_growdev/services/api.dart';

class CardController {
  Future? criarCard(String token, String title, String content) async {
    await Api(token: token)
        .criarCard(CardModel(title: title, content: content));
  }
}

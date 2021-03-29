import 'package:app_growdev/models/user_model.dart';
import 'package:app_growdev/services/api.dart';
import 'package:dio/dio.dart';

class SubscribeController {
  UserModel? user;
  String? token;
  final service = Api();

  Future<bool> fazerCadastro(String nome, String email, String senha) async {
    Response response = await service.fazerCadastro(
      UserModel(name: nome, email: email, password: senha),
    );

    try {
      if (response.statusCode == 200) {
        user = Api.fromMap(response.data).user;
        token = Api.fromMap(response.data).token;
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }

    return false;
  }
}

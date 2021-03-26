import 'package:app_growdev/models/user_model.dart';
import 'package:app_growdev/services/api.dart';
import 'package:dio/dio.dart';

class SubscribeController {
  final service = Api();

  Future<bool> fazerCadastro(String nome, String email, String senha) async {
    Response response = await service.fazerCadastro(
      UserModel(name: nome, email: email, password: senha),
    );
    if (response.statusCode == 200) return true;
    return false;
  }
}

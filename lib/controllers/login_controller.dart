import 'package:app_growdev/models/user_model.dart';
import 'package:app_growdev/services/api.dart';
import 'package:dio/dio.dart';

class LoginController {
  UserModel? user;
  String? token;
  final service = Api();
  Future<bool> fazerLogin(String email, String senha) async {
    Response response =
        await service.fazerLogin(UserModel(email: email, password: senha));
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

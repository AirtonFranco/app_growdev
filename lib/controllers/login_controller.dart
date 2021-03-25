import 'package:app_growdev/models/user_model.dart';
import 'package:app_growdev/services/api.dart';

class LoginController {
  final service = Api();
  void fazerLogin(String email, String senha) async {
    var response = await service.fazerLogin(
      UserModel(email: email, senha: senha),
    );

    print('CONTROLER: $response');
  }
}

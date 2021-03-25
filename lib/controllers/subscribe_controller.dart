import 'package:app_growdev/models/user_model.dart';
import 'package:app_growdev/services/api.dart';

class SubscribeController {
  final service = Api();

  void fazerCadastro(String nome, String email, String senha) async {
    print('$nome $email $senha');
    var response = await service.fazerCadastro(
      UserModel(nome: nome, email: email, senha: senha),
    );

    print('CONTROLER: $response');
  }
}

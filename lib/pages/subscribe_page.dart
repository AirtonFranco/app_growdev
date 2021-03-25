import 'package:app_growdev/controllers/subscribe_controller.dart';
import 'package:app_growdev/theme/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SubscribePage extends StatefulWidget {
  SubscribePage({Key? key}) : super(key: key);

  @override
  _SubscriberPageState createState() => _SubscriberPageState();
}

class _SubscriberPageState extends State<SubscribePage> {
  final formKey = GlobalKey<FormState>();
  final controller = SubscribeController();
  String? nome;
  String? email;
  String? pass;
  void _doSingUp() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    controller.fazerCadastro(nome!, email!, pass!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: azulGrowdev,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          margin:
              const EdgeInsets.only(top: 80, bottom: 40, left: 16, right: 16),
          color: Colors.white10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                height: 100,
                child: Image.asset('images/growdev_branco.png'),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return 'Preencha o Nome';

                          return null;
                        },
                        onSaved: (value) => nome = value,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          suffixIcon: Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white24,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return 'Preencha o Email';
                          if (!EmailValidator.validate(value))
                            return 'Email inválido';
                          return null;
                        },
                        onSaved: (value) => email = value,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          suffixIcon: Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.white24,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return 'Preencha a Senha';

                          return null;
                        },
                        onSaved: (value) => pass = value,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: Colors.white24,
                          suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {}),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _doSingUp();
                        },
                        child: Text('Criar Conta'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          primary: laranjaGrowdev,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

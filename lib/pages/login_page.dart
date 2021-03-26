import 'package:app_growdev/controllers/login_controller.dart';
import 'package:app_growdev/pages/home_page.dart';
import 'package:app_growdev/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

var _checked = true;
var _isObsecurePass = true;
var _isLoading = false;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final controller = LoginController();
  String? email;
  String? pass;

  void _doLogin() {
    setState(() {
      _isLoading = true;
    });
    if (!formKey.currentState!.validate()) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    formKey.currentState!.save();

    controller.fazerLogin(email!, pass!).then((value) {
      if (!value) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Falha no login. Tente novamente.',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: laranjaGrowdev,
          ),
        );
      } else {
        //Navigator.pushNamed(context, '/home-page');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      nome: controller.user!.name,
                      email: controller.user!.email,
                      token: controller.token!,
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: azulGrowdev,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          margin:
              const EdgeInsets.only(top: 40, bottom: 40, left: 16, right: 16),
          color: Colors.white10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 100,
                child: Image.asset('images/growdev_branco.png'),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Novo por aqui? ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/subscribe-page');
                    },
                    child: Text(
                      'Crie a sua conta aqui',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: laranjaGrowdev,
                      ),
                    ),
                  )
                ],
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
                        initialValue: 'thobias@gmail.com',
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
                        initialValue: 'thobias@2021',
                        validator: (value) {
                          if (value!.isEmpty) return 'Preencha a Senha';
                        },
                        onSaved: (value) => pass = value,
                        keyboardType: TextInputType.text,
                        obscureText: _isObsecurePass,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: Colors.white24,
                          suffixIcon: _isObsecurePass
                              ? IconButton(
                                  splashRadius: 0.1,
                                  icon: Icon(Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObsecurePass = false;
                                    });
                                  },
                                )
                              : IconButton(
                                  splashRadius: 0.1,
                                  icon: Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObsecurePass = true;
                                    });
                                  },
                                ),
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
                      CheckboxListTile(
                        title: Text(
                          'Mantenha-me conectado',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        value: _checked,
                        onChanged: (newValue) {
                          setState(() {
                            _checked = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),

                      /* Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _checked = !_checked;
                              });
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              color: Colors.white24,
                              child: Visibility(
                                visible: _checked,
                                replacement: Container(),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Mantenha-me conectado',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ), */
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _doLogin();
                          },
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                )
                              : Text('Entrar'),
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

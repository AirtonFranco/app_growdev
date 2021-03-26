import 'package:flutter/material.dart';

import 'package:app_growdev/controllers/card_controller.dart';
import 'package:app_growdev/theme/colors.dart';

class CardPage extends StatefulWidget {
  String? token;
  CardPage({
    Key? key,
    this.token,
  }) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  String? title;
  String? content;
  final formKey = GlobalKey<FormState>();

  final controller = CardController();

  void salvar() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    print(widget.token!);
    print(title!);
    print(content!);
    await controller.criarCard(widget.token!, title!, content!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Card: Novo'),
        brightness: Brightness.dark,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) return 'Coloque um titulo';
                        return null;
                      },
                      onSaved: (value) => title = value,
                      decoration: InputDecoration(
                        labelText: 'Titulo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      maxLines: 10,
                      validator: (value) {
                        if (value!.isEmpty) return 'Coloque um conteudo';
                        return null;
                      },
                      onSaved: (value) => content = value,
                      decoration: InputDecoration(
                        labelText: 'Conteúdo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  salvar();
                },
                child: Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  primary: laranjaGrowdev,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
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

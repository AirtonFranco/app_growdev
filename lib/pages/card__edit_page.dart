import 'package:app_growdev/controllers/home_controller.dart';
import 'package:app_growdev/models/card_model.dart';
import 'package:app_growdev/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:app_growdev/controllers/card_controller.dart';
import 'package:app_growdev/theme/colors.dart';
import 'package:hive/hive.dart';

class CardEditPage extends StatefulWidget {
  CardModel? card;
  CardEditPage({Key? key, this.card}) : super(key: key);

  @override
  _CardEditPageState createState() => _CardEditPageState();
}

class _CardEditPageState extends State<CardEditPage> {
  final box = Hive.box('user_info');
  String? token;
  bool isLoading = false;
  String? title;
  String? content;
  final formKey = GlobalKey<FormState>();
  final controller = CardController();

  @override
  void initState() {
    super.initState();
    token = box.get('token');
  }

  void salvar() async {
    isLoading = true;
    setState(() {});
    if (!formKey.currentState!.validate()) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    formKey.currentState!.save();

    await controller
        .editarCard(token!, widget.card!.id!, title!, content!)
        .then((value) {
      if (!value) return;

      Navigator.pushReplacementNamed(context, '/home-page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Card: Editar'),
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
                      initialValue: widget.card!.title,
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
                      initialValue: widget.card!.content,
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
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    salvar();
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : Text('Salvar'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

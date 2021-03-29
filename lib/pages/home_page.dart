import 'package:app_growdev/controllers/home_controller.dart';
import 'package:app_growdev/models/card_model.dart';
import 'package:app_growdev/pages/card__edit_page.dart';
import 'package:app_growdev/pages/card_page.dart';
import 'package:flutter/material.dart';

import 'package:app_growdev/theme/colors.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  /* final String? nome;
  final String? email;
  final String? token; */
/*   const HomePage({
    Key? key,
    this.nome,
    this.email,
    this.token,
  }) : super(key: key);
 */
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final box = Hive.box('user_info');
  String? name;
  String? email;
  String? token;
  List<CardModel>? lista = [];
  Future<List<CardModel>>? futurelista;
  @override
  void initState() {
    super.initState();
    token = box.get('token');
    email = box.get('email');
    name = box.get('name');
    buscarTodosCards();
  }

  void buscarTodosCards() async {
    //  lista = await controller.buscarTodosCards(token!);
    futurelista = controller.buscarTodosCards(token!);
    setState(() {});
  }

  void buscarCardId(int id) async {}

  void deletarCard(CardModel card) async {
    await controller.deletarCard(token!, card.id!).then((value) {
      if (value) {
        buscarTodosCards();
      }
    });
  }

  Future<void> _refresh() async {
    List<CardModel> listaRefresh = await controller.buscarTodosCards(token!);
    setState(() {
      futurelista = Future.value(listaRefresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
        brightness: Brightness.dark,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/card-page');
              /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CardPage(
                            
                          ))); */
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: azulGrowdev,
              child: UserAccountsDrawerHeader(
                accountName: Text(name!),
                accountEmail: Text(email!),
                currentAccountPicture: CircleAvatar(
                  child: Icon(
                    Icons.person,
                    color: laranjaGrowdev,
                    size: 40,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Desconectar'),
              selectedTileColor: Colors.grey[300],
              onTap: () {
                box.put('isLogged', false);
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
          future: futurelista,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              lista = (snapshot.data as List<CardModel>);
              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  itemCount: lista!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: laranjaGrowdev,
                              width: 2.0,
                            )),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.55,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: laranjaGrowdev,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            style: BorderStyle.solid,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${lista![index].id!}',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          lista![index].title!,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  Expanded(
                                    child: Text(
                                      lista![index].content!,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CardEditPage(
                                                        card: lista![index],
                                                      )));
                                        },
                                        child: Text(
                                          'Editar',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deletarCard(lista![index]);
                                        },
                                        child: Text(
                                          'Remover',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}


/*shape: StadiumBorder(
                side: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ), */
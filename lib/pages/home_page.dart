import 'package:app_growdev/controllers/home_controller.dart';
import 'package:app_growdev/pages/card_page.dart';
import 'package:flutter/material.dart';

import 'package:app_growdev/theme/colors.dart';

class HomePage extends StatefulWidget {
  final String? nome;
  final String? email;
  final String? token;
  const HomePage({
    Key? key,
    this.nome,
    this.email,
    this.token,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  @override
  void initState() {
    super.initState();
    print('HOME PAGE');
    controller.buscarTodosCards(widget.token!);
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
              // Navigator.of(context).pushNamed('/card-page');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CardPage(token: widget.token!)));
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
                accountName: Text(widget.nome!),
                accountEmail: Text(widget.email!),
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
              leading: Icon(Icons.home),
              title: Text('Home'),
              selected: false,
              selectedTileColor: Colors.grey[300],
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Desconectar'),
              selectedTileColor: Colors.grey[300],
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 4,
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
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Um titulo qualquer para o card que o aluno vai colocar',
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
                          '''
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in
                          ''',
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Editar',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
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
          );
        },
      ),
    );
  }
}


/*shape: StadiumBorder(
                side: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ), */
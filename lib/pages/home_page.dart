import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      drawer: Drawer(
        child: UserAccountsDrawerHeader(
          accountName: Text('Nome Usuario'),
          accountEmail: Text('Email Usuario'),
        ),
      ),
    );
  }
}

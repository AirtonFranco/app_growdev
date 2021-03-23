import 'package:app_growdev/pages/home_page.dart';
import 'package:app_growdev/theme/colors.dart';
import 'package:flutter/material.dart';

import 'pages/card_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'App Growdev',
    theme: ThemeData(
      primarySwatch: azulGrowdev,
      accentColor: laranjaGrowdev,
    ),
    home: HomePage(),
  ));
}

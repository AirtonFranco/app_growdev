import 'package:app_growdev/theme/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'App Growdev',
    theme: ThemeData(
      primarySwatch: azulGrowdev,
      accentColor: laranjaGrowdev,
    ),
  ));
}

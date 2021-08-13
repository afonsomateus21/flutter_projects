import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:segundo_app_responsivo/pages/home/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: "Exemplo 2",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue
    ),
    builder: (context, widget) => ResponsiveWrapper.builder(
      ClampingScrollWrapper.builder(context, widget),
      defaultScale: true,
      minWidth: 450,
      defaultName: MOBILE,
      breakpoints: [
        ResponsiveBreakpoint.resize(450, name: MOBILE),
        ResponsiveBreakpoint.resize(700, name: TABLET),
        ResponsiveBreakpoint.resize(800, name: DESKTOP),
      ]
    ),
    home: Home(),
  ));
}


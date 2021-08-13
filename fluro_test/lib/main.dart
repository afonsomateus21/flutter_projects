import 'package:fluro_test/router.dart';
import 'package:flutter/material.dart';

void main() {
  Routes.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluro Tutorial',
      initialRoute: '/login',
      onGenerateRoute: Routes.router.generator
    );
  }
}
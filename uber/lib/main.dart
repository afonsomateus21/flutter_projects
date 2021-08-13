import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber/route_generator.dart';
import 'package:uber/screens/login_page.dart';

final ThemeData theme = ThemeData(
  primaryColor: Color(0xff3747af),
  accentColor: Color(0xff546e7a)
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: Login(),
    theme: theme,
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}


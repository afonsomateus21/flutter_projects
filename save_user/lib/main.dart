import 'package:flutter/material.dart';
import 'package:save_user/pages/login_page.dart';
import 'package:save_user/route_generator.dart';

void main() {
  runApp(MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}


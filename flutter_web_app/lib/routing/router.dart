import 'package:flutter/material.dart';
import 'package:flutter_web_app/routing/route_names.dart';
import 'package:flutter_web_app/view/about/about_view.dart';
import 'package:flutter_web_app/view/episodes/episodes_view.dart';
import 'package:flutter_web_app/view/home/home_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch(settings.name) {
    case HOME_ROUTE:
      return _getPageRoute(HomeView());
    case ABOUT_ROUTE:
      return _getPageRoute(AboutView());
    case EPISODES_ROUTE:
      return _getPageRoute(EpisodesView());
    default:
      return null;
  }
}

PageRoute _getPageRoute(Widget child) {
  return _FadeRoute(child);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  _FadeRoute(this.child) :
  super(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) => child,
    transitionDuration: Duration(milliseconds: 10),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) => FadeTransition(opacity: animation, child: child)
  );
}
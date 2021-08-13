import 'package:flutter/material.dart';
import 'package:flutter_web_tests/pages/home_page.dart';
import 'package:flutter_web_tests/pages/profile_page.dart';

const HOME_ROUTE = "/";
const PROFILE_ROUTE = "/profile";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch(settings.name) {
    case HOME_ROUTE:
      return _getPageRoute(HomePage(), settings);
    case PROFILE_ROUTE:
      return _getPageRoute(ProfilePage(), settings);
    default:
      return null;
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child, settings);
}

/*MaterialPageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      return _FadeRoute(child);
    }
  );
}*/

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final RouteSettings settings;
  _FadeRoute(this.child, this.settings) : super(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation
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

/*class _FadeRoute<T> extends MaterialPageRoute<T> {
  _FadeRoute({WidgetBuilder builder, RouteSettings settings})
    : super(builder: builder, settings: settings);

  @override 
  Widget buildTransitions(BuildContext context, 
                          Animation<double> animation, 
                          Animation<double> secondaryAnimation, 
                          Widget child) {
    if (settings.name == HOME_ROUTE) {
      return child;
    }

    return FadeTransition(opacity: animation, child: child);
  }

}*/
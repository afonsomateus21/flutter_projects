import 'package:flutter/material.dart';
import 'package:flutter_web_app/view/widgets/centered_view/centered_view.dart';
import 'package:flutter_web_app/view/widgets/navigation_bar/navigation_bar.dart';
import 'package:flutter_web_app/view/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplate extends StatelessWidget {
  final Widget child;
  const LayoutTemplate({ Key key, this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) { 
        return Scaffold(
          drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
           ? NavigationDrawer()
           : null,
          backgroundColor: Colors.white,
          body: CenteredView(
            child: Column(
              children: [
                NavigationBar(),
                Expanded(
                  /*child: Navigator(
                    key: locator<NavigationService>().navigatorKey,
                    onGenerateRoute: generateRoute,
                    initialRoute: HOME_ROUTE,
                  )*/
                  child: child,
                )
              ]
            ),
          )
        );
      }
    );
  }
}
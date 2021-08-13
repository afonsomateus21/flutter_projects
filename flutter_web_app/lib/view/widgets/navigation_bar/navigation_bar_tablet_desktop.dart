import 'package:flutter/material.dart';
import 'package:flutter_web_app/routing/route_names.dart';
import 'package:flutter_web_app/view/widgets/navigation_bar/navbar_item.dart';
import 'package:flutter_web_app/view/widgets/navigation_bar/navbar_logo.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavBarItem("Episodes", EPISODES_ROUTE),
              SizedBox(width: 60),
              NavBarItem("About", ABOUT_ROUTE)
            ]
          )
        ]
      ),
    );
  }
}
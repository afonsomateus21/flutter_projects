import 'package:flutter/material.dart';
import 'package:flutter_web_app/routing/route_names.dart';
import 'package:flutter_web_app/view/widgets/navigation_drawer/drawer_item.dart';
import 'package:flutter_web_app/view/widgets/navigation_drawer/navigation_drawer_header.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16
          )
        ]
      ),
      child: Column(
        children: [
          NavigationDrawerHeader(),
          DrawerItem("Episodes", Icons.videocam, EPISODES_ROUTE),
          DrawerItem("About", Icons.help, ABOUT_ROUTE)
        ]
      ),
    );
  }
}
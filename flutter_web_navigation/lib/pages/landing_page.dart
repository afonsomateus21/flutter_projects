import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/pages/about_page.dart';
import 'package:flutter_web_navigation/pages/help_page.dart';
import 'package:flutter_web_navigation/pages/home_page.dart';
import 'package:flutter_web_navigation/pages/profile_page.dart';
import 'package:flutter_web_navigation/pages/settings_page.dart';
import 'package:flutter_web_navigation/widgets/nav_item.dart';

class LandingPage extends StatefulWidget {
  final String page;
  final String extra; 

  const LandingPage({Key key, this.page, this.extra}) : super(key: key);
  
  @override
  _LandingPageState createState() => _LandingPageState();
}

List<String> pages = [
  'home',
  'about',
  'profile',
  'settings',
  'help'
];

List<IconData> icons = [
  Icons.home,
  Icons.pages_rounded,
  Icons.person_rounded,
  Icons.settings_rounded,
  Icons.help_rounded
];

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: icons.map((e) {
                  return NavItem(
                    selected: icons.indexOf(e) == pages.indexOf(widget.page),
                    icon: e,
                    onTap: () {
                      if (icons.indexOf(e) == 1) {
                        Navigator.pushNamed(
                          context, 
                          "/main/${pages[icons.indexOf(e)]}/Mateus"
                        );
                      } else {
                        Navigator.pushNamed(
                          context, 
                          "/main/${pages[icons.indexOf(e)]}"
                        );
                      }
                    },
                  );
                }).toList()
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                child: IndexedStack(
                  children: [
                    HomePage(),
                    AboutPage(widget.extra),
                    ProfilePage(),
                    SettingsPage(),
                    HelpPage()
                  ]
                )
              ),
            )
          ]
        )
      ),
    );
  }
}
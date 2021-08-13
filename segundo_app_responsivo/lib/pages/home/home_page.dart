import 'package:flutter/material.dart';
import 'package:segundo_app_responsivo/pages/home/widgets/post_widget.dart';
import 'package:segundo_app_responsivo/pages/home/widgets/responsive_app_bar.dart';
import 'package:segundo_app_responsivo/pages/home/widgets/right_panel.dart';
import 'package:segundo_app_responsivo/pages/home/widgets/stories_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 52),
        child: ResponsiveAppBar(),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 1000,
          ),
          child: Row(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    StoriesList(),
                    PostWidget(),
                    PostWidget(),
                    PostWidget()
                  ]
                ),
              ),
              RightPanel()
            ]
          )
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:segundo_app_responsivo/pages/home/widgets/story_circle.dart';

class StoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mobile = ResponsiveWrapper.of(context).isMobile;

    return Container(
      height: 110,
      margin: EdgeInsets.only(top: mobile ? 15 : 35),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (_, __) => SizedBox(width: 16), 
        itemCount: 16,
        itemBuilder: (_, index) => StoryCircle(),
      ),
    );
  }
}
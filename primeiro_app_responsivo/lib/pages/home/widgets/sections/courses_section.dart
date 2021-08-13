import 'package:flutter/material.dart';
import 'package:primeiro_app_responsivo/breakpoints.dart';
import 'package:primeiro_app_responsivo/pages/home/widgets/course_item.dart';

class CoursesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16
          ),
          padding: EdgeInsets.symmetric(
            vertical: 16, 
            horizontal: constraints.maxWidth >= tabletBreakpoint 
              ? 0
              : 16
          ),
          itemCount: 20,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CourseItem();
          },
        );
      }
    );
  }
}
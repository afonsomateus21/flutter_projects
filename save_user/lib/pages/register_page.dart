import 'package:flutter/material.dart';
import 'package:save_user/breakpoints.dart';
import 'package:save_user/widgets/app_bar/mobile_app_bar.dart';
import 'package:save_user/widgets/section/register_fields.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.black,

          appBar: constraints.maxWidth < mobileBreakpoint 
            ? PreferredSize(
              child: MobileAppBar(), 
              preferredSize: Size(double.infinity, 56)
            )
            : null,

          body: constraints.maxWidth < mobileBreakpoint
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: RegisterFields(),
                    )
                  ]
                )
              )
          
            : Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 500,
                      child: RegisterFields()
                    )
                  ]
                )
              ),
        );
      },
    );
  }
}
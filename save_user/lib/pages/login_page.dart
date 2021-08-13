import 'package:flutter/material.dart';
import 'package:save_user/breakpoints.dart';
import 'package:save_user/widgets/app_bar/mobile_app_bar.dart';
import 'package:save_user/widgets/section/login_fields.dart';

class Login extends StatelessWidget {
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
                      child: LoginFields(),
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
                      child: LoginFields()
                    ),
                  ]
                ),
              ),
        );
      },
    );
  }
}
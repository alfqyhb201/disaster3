import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:flutter/material.dart';

AppBar customAppBar2(callbackAction, bool isLogout) {
  return AppBar(
    title: SizedBox(
      width: double.infinity,
      height: 40,
      child: MoveWindow(
        child: Row(
          children: [
            SizedBox(
              width: 40.0,
              child: Image.asset(
                'asset/logo.png',
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              'Disaster',
              style: TextStyle(color: blueColor),
            ),
          ],
        ),
      ),
    ),
    leadingWidth: isLogout ? 30.0 : 0.0,
    leading: isLogout ? callbackAction : Container(),
    actions: [
      MinimizeWindowButton(
        colors: WindowButtonColors(
          iconNormal: blueColor,
        ),
      ),
      MaximizeWindowButton(
        colors: WindowButtonColors(
          iconNormal: blueColor,
        ),
      ),
      if (!isLogout)
        CloseWindowButton(
          colors: WindowButtonColors(
            iconNormal: blueColor,
          ),
        ),
    ],
  );
}

AppBar customAppBar(bool disableClose) => AppBar(
      title: SizedBox(
        width: double.infinity,
        height: 40,
        child: MoveWindow(
          child: Row(
            children: [
              SizedBox(
                width: 40.0,
                child: Image.asset(
                  'asset/logo.png',
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                'Disaster',
                style: TextStyle(color: blueColor),
              ),
            ],
          ),
        ),
      ),
      actions: [
        MinimizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: blueColor,
          ),
        ),
        MaximizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: blueColor,
          ),
        ),
        if (!disableClose)
          CloseWindowButton(
            colors: WindowButtonColors(
              iconNormal: blueColor,
            ),
          ),
      ],
    );

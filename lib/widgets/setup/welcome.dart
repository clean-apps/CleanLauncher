import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 100, 0, 100),
          child: Image.asset(
            Theme.of(context).brightness == Brightness.dark
                ? 'assets/app-logo-dark.png'
                : 'assets/app-logo-light.png',
            height: 196,
            width: 196,
          ),
        ),
        Text(
          'Welcome To',
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          'Clean Launcher',
          style: Theme.of(context).textTheme.headline3,
        ),
      ],
    );
  }
}

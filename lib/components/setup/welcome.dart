import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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

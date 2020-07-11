import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 100, 0, 100),
          child: SvgPicture.asset(
            Theme.of(context).brightness == Brightness.dark
                ? 'assets/feather.svg'
                : 'assets/feather_black.svg',
            height: 128,
            width: 128,
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

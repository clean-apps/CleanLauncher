import 'package:flutter/material.dart';
import 'package:CleanLauncher/components/setup/welcome.dart';

import 'package:CleanLauncher/pages/setup_fav_apps.dart';

class SetupWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: WelcomeWidget()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SetupFavApps()),
          );
        },
        label: Text('NEXT'),
        icon: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}

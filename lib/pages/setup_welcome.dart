import 'package:flutter/material.dart';
import 'package:CleanLauncher/components/setup/welcome.dart';

class SetupWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: WelcomeWidget()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/favorites'),
        label: Text('NEXT'),
        icon: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}

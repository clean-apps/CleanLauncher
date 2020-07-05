import 'package:flutter/material.dart';

final darkTheme = _generateTheme(
  highlight: Colors.yellow,
);

final lightTheme = _generateTheme(
  isDark: false,
  text: Colors.black,
  highlight: Colors.deepPurple,
);

ThemeData _generateTheme({
  bool isDark = true,
  Color text = Colors.white,
  Color highlight = Colors.blue,
}) {
  //
  return ThemeData(
    brightness: isDark ? Brightness.dark : Brightness.light,
    primaryColor: isDark ? Colors.black : Colors.white,
    scaffoldBackgroundColor: isDark ? Colors.black87 : Colors.white,
    accentColor: isDark ? Colors.black87 : Colors.white,
    textTheme: TextTheme(
        headline5: TextStyle(color: text.withOpacity(0.5)),
        headline4: TextStyle(color: text.withOpacity(0.5)),
        headline3: TextStyle(color: text),
        caption: TextStyle(color: highlight)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

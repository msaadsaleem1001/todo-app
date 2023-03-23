import 'package:flutter/material.dart';

class TodoTextTheme{
  static TextTheme lightTextTheme = TextTheme(
    displaySmall: TextStyle(color: Colors.grey.shade700, fontSize: 16),
    displayMedium: TextStyle(color:Colors.grey.shade700,fontWeight: FontWeight.bold, fontSize: 20),
    displayLarge: TextStyle(color: Colors.grey.shade700, fontSize: 25),
  );
  static TextTheme darkTextTheme = const TextTheme(
    displaySmall: TextStyle(color: Colors.white60, fontSize: 16),
    displayMedium: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold, fontSize: 20),
    displayLarge: TextStyle(color: Colors.white60, fontSize: 25),
  );

}
import 'package:flutter/material.dart';
import 'package:todo_app/app_theme/theme_data.dart';
import 'package:todo_app/homescreen.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TodoAppTheme.lightTheme,
      darkTheme: TodoAppTheme.darkTheme,
      themeMode: ThemeMode.system,

      home: const HomeScreen(),
    );
  }
}

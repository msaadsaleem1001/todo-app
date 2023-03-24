import 'package:flutter/material.dart';
import 'package:todo_app/app_theme/text_theme.dart';

class TodoAppTheme {
  TodoAppTheme._();

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.yellow,
    brightness: Brightness.light,
    textTheme: TodoTextTheme.lightTextTheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      toolbarTextStyle: TodoTextTheme.lightTextTheme.displayMedium,
      titleTextStyle: TodoTextTheme.lightTextTheme.displayMedium,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
    iconTheme: IconThemeData(
      color: Colors.grey.shade700,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      iconColor: Colors.black,
      titleTextStyle: TodoTextTheme.lightTextTheme.displayMedium,
      contentTextStyle: TodoTextTheme.lightTextTheme.displaySmall,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.light(),
      textTheme: ButtonTextTheme.normal,
    ),
    switchTheme: const SwitchThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.redAccent),
      hintStyle: TextStyle(color: Colors.grey.shade800),
    ),
    popupMenuTheme: const PopupMenuThemeData(
        enableFeedback: false, elevation: 10, color: Colors.white),
  );

  static ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
      textTheme: TodoTextTheme.darkTextTheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        toolbarTextStyle: TodoTextTheme.darkTextTheme.bodyMedium,
        titleTextStyle: TodoTextTheme.darkTextTheme.titleLarge,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white70,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(),
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.grey.shade800,
        titleTextStyle: TodoTextTheme.darkTextTheme.displayMedium,
        contentTextStyle: TodoTextTheme.darkTextTheme.displaySmall,
      ),
      buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.redAccent.shade100),
      ),
      popupMenuTheme: PopupMenuThemeData(
          enableFeedback: false, elevation: 10, color: Colors.grey.shade600));
}

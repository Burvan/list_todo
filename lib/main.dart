import 'package:flutter/material.dart';
import 'package:list_todo/pages/home.dart';
import 'package:list_todo/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Инициализация в основной функции
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.orangeAccent,
    ),
    initialRoute: '/',
    routes: {
      // Маршрутизация
      '/': (context) => MainScreen(),
      '/todo': (context) => Home(),
    },
  ));
}

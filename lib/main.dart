import 'package:calling_api1/screen/home.dart';
import 'package:calling_api1/screen/internet.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Random userApi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Homescreen(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:sqlflutter/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TaskBDApp",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

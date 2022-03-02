import 'package:flutter/material.dart';
import 'package:flutter_app7/pages/register_form_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterFormPage(),
    );
  }
}

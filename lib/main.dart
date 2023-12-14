import 'package:client_application/pages/loginPage/loginPage.dart';
import 'package:client_application/pages/loginPage/loginWithPasswordPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      home: LoginWithPasswordPage()
    );
  }
}

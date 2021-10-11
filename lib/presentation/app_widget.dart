import 'package:flutter/material.dart';
import 'package:flutter_cubit_1/presentation/home/home_page.dart';
import 'package:flutter_cubit_1/presentation/sign_in/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
    );
  }
}

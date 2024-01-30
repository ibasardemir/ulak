import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/register_provider.dart';
import 'package:ulak/pages/auth_page.dart';
import 'package:ulak/pages/register_page.dart';
// 
Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Material app arka plan rengi
      ),
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: const AuthPage(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/database_messages_provider.dart';
import 'package:ulak/bloc/register_provider.dart';
import 'package:ulak/pages/auth_page.dart';
import 'package:ulak/pages/debug_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Material app arka plan rengi
      ),
      home:  MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<MessageDatabaseBloc>(
          create: (context) => MessageDatabaseBloc(),
        ),
        // Diğer BlocProvider'lar buraya eklenebilir
      ],
      child: const MaterialApp(
        home: AuthPage(),
      ),
    ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/database_messages_provider.dart';
import 'package:ulak/bloc/login_provider.dart';
import 'package:ulak/bloc/messages_bloc.dart';
import 'package:ulak/bloc/otp_login_provider.dart';
import 'package:ulak/bloc/otp_provider.dart';
import 'package:ulak/bloc/register_provider.dart';
import 'package:ulak/bloc/users_all_list_provider.dart';
import 'package:ulak/pages/auth/auth_page.dart';
import 'package:ulak/network/flutternearby.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:ulak/pages/auth/debug_page.dart';
import 'firebase_options.dart';

//Hi
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final RegisterBloc registerBloc = RegisterBloc();
  final LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (context) => registerBloc,
        ),
        BlocProvider<LoginBloc>(
          create: (context) => loginBloc,
        ),
        BlocProvider<MessageDatabaseBloc>(
          create: (context) => MessageDatabaseBloc(),
        ),
        BlocProvider<OTPBloc>(
          create: (context) => OTPBloc(registerBloc: registerBloc)
        ),
        BlocProvider<OTPLoginBloc>(
          create: (context) => OTPLoginBloc(loginBloc: loginBloc)
        ),
        BlocProvider<MessagesBloc>(
          create: (context) => MessagesBloc()
        ),
        BlocProvider<UserMessagesBloc>(
          create: (context) => UserMessagesBloc()
        )
      ],
      child: MaterialApp(
        home: AuthPage(),
      ),
    ),
    );
  }
}

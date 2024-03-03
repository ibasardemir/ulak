import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ulak/bloc/database_messages_provider.dart';
import 'package:ulak/bloc/login_provider.dart';
import 'package:ulak/bloc/messages_bloc.dart';
import 'package:ulak/bloc/otp_login_provider.dart';
import 'package:ulak/bloc/otp_provider.dart';
import 'package:ulak/bloc/register_provider.dart';
import 'package:ulak/bloc/users_all_list_provider.dart';
import 'package:ulak/pages/auth/auth_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:location/location.dart';

//Hi
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());

  // location permission
  await Permission.location.isGranted; // Check
  await Permission.location.request(); // Ask

// location enable dialog
  await Location.instance.requestService();

// external storage permission
  await Permission.storage.isGranted; // Check
  await Permission.storage.request(); // Ask

// Bluetooth permissions
  bool granted = !(await Future.wait([
    // Check
    Permission.bluetooth.isGranted,
    Permission.bluetoothAdvertise.isGranted,
    Permission.bluetoothConnect.isGranted,
    Permission.bluetoothScan.isGranted,
  ]))
      .any((element) => false);
  [
    // Ask
    Permission.bluetooth,
    Permission.bluetoothAdvertise,
    Permission.bluetoothConnect,
    Permission.bluetoothScan
  ].request();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final RegisterBloc registerBloc = RegisterBloc();
  final LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
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
              create: (context) => OTPBloc(registerBloc: registerBloc)),
          BlocProvider<OTPLoginBloc>(
              create: (context) => OTPLoginBloc(loginBloc: loginBloc)),
          BlocProvider<MessagesBloc>(create: (context) => MessagesBloc()),
          BlocProvider<UserMessagesBloc>(
              create: (context) => UserMessagesBloc())
        ],
        child: const MaterialApp(
          home: AuthPage(),
        ),
      ),
    );
  }
}

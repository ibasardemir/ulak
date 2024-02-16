import 'package:flutter/material.dart';
import 'package:ulak/components/auth/fixed_button.dart';
import 'package:ulak/components/debug/debug_button.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthWidget();
  }
}

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 600,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(40),
                child: Image.asset(
                    'assets/ulak_logo.jpg',
                    fit: BoxFit.cover, 
                  ),
              )),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10),
                      child:  const FixedButton(name: "Register",otpValues: [],)),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child:  const FixedButton(name: "Login",otpValues: [],)),
                     
                ],
                
              ))
          ])
        ),
      ),
    );
  }
}

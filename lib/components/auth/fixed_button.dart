import 'package:flutter/material.dart';
import 'package:ulak/pages/auth/login_page.dart';
import 'package:ulak/pages/auth/register_page.dart';


class FixedButton extends StatelessWidget {
  final String name;

  const FixedButton({super.key, required this.name,});

  @override
  Widget build(BuildContext context) {

    double containerWidth = MediaQuery.of(context).size.width * 0.9;

    return SizedBox(
      width: containerWidth,
      height: 50.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFFF8C00), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 2, 
        ),
        onPressed: () {
          if(name == "Register"){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
          }
          else if(name == "Login"){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        },
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
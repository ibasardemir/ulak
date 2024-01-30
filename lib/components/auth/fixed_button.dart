import 'package:flutter/material.dart';
import 'package:ulak/pages/register_page.dart';

import '../../pages/login_page.dart';


class FixedButton extends StatelessWidget {
  final String name;

  FixedButton({required this.name,});

  @override
  Widget build(BuildContext context) {

    double containerWidth = MediaQuery.of(context).size.width * 0.9;

    return Container(
      width: containerWidth,
      height: 50.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(0xFFFF8C00), 
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/otp_login_provider.dart';
import 'package:ulak/bloc/otp_provider.dart';
import 'package:ulak/database/auth.dart';
import 'package:ulak/pages/app/main_app_page.dart';
import 'package:ulak/pages/auth/login_page.dart';
import 'package:ulak/pages/auth/register_page.dart';

class FixedButton extends StatelessWidget {
  final String name;
  final List<String> otpValues;
  final String otpCode;

  const FixedButton({super.key, required this.name, required this.otpValues,this.otpCode="123456"});

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
        onPressed: () async {
          if (name == "Register") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterPage()));
          } else if (name == "Login") {
            Authentication auth =Authentication();  
            if(await auth.isLogin()){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
            }
            else{
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  MainPage()));
            }
            
          } else if (name == "Verify") {
            bool isFilled = otpValues.every((element) => element.isNotEmpty);
            if (!isFilled) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill in all the fields')),
              );
            }
            else{
              
              String userCode = "";
              otpValues.forEach((element) { 
                userCode = userCode + element;
              });
              print(userCode);
              BlocProvider.of<OTPBloc>(context).add(OTPControl(code: userCode));
            }
          } else if (name == "Verify Login"){
            bool isFilled = otpValues.every((element) => element.isNotEmpty);
            if (!isFilled) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill in all the fields')),
              );
            }
            else{
              String userCode = "";
              otpValues.forEach((element) { 
                userCode = userCode + element;
              });
              print(userCode);
              BlocProvider.of<OTPLoginBloc>(context).add(OTPLoginControl(code: userCode));
            }
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

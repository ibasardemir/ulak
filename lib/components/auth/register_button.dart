import 'package:flutter/material.dart';
import 'package:ulak/bloc/register_provider.dart';
import 'package:ulak/pages/otp_page.dart';
import 'package:ulak/pages/register_page.dart';

class RegisterButton extends StatelessWidget {
  final String name;
  final TextEditingController userNameController;
  final TextEditingController phoneNumberController;
  final LoginBloc loginBloc;
  final GlobalKey<FormState> formKey;

  RegisterButton({required this.name, required this.userNameController, required this.phoneNumberController, required this.loginBloc,required this.formKey});

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
          if (formKey.currentState!.validate()) {
            loginBloc.add(LoginButtonPressed(username: userNameController.text, password: phoneNumberController.text));
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OTPPage()
              ));
          }
        },
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:ulak/bloc/login_provider.dart';

class LoginButton extends StatelessWidget {
  final String name;
  final TextEditingController userNameController;
  final TextEditingController phoneNumberController;
  final LoginBloc loginBloc;
  final GlobalKey<FormState> formKey;

  const LoginButton({super.key, required this.name, required this.userNameController, required this.phoneNumberController, required this.loginBloc,required this.formKey});

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
          if (formKey.currentState!.validate()) {
            loginBloc.add(LoginButtonPressed(phoneNumber: phoneNumberController.text));
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
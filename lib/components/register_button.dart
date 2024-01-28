import 'package:flutter/material.dart';
import 'package:ulak/bloc/register_provider.dart';

class RegisterButton extends StatelessWidget {
  final String name;
  final TextEditingController userNameController;
  final TextEditingController phoneNumberController;
  final LoginBloc loginBloc;

  const RegisterButton({super.key, required this.name, required this.userNameController, required this.phoneNumberController, required this.loginBloc});

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
          loginBloc.add(LoginButtonPressed(username: userNameController.text, password: phoneNumberController.text));
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
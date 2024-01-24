import 'package:flutter/material.dart';


class RegisterTextField extends StatelessWidget 
{
  final TextEditingController textController;
  final String iconName;

  RegisterTextField({required this.iconName, required this.textController});

  @override
  Widget build(BuildContext context) {
  double containerWidth = MediaQuery.of(context).size.width * 0.9;
  bool isPhoneField = iconName.toLowerCase() == 'phone';

    return Container(
      width: containerWidth,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: TextFormField(
        controller: textController,
        style: TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Phone number',
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.all(14.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: isPhoneField
              ? Icon(
                  Icons.phone,
                  color: Colors.grey,
                )
              : Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                ),
        ),
      ),
    );
  }
}

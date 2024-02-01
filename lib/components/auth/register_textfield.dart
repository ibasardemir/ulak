import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterTextField extends StatefulWidget {
  final TextEditingController textController;
  final String iconName;

  const RegisterTextField({super.key, required this.iconName, required this.textController});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterTextFieldState createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {

  @override
  Widget build(BuildContext context) {
    bool isPhoneField = widget.iconName.toLowerCase() == 'phone';

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.textController,
        keyboardType: TextInputType.number,
        inputFormatters: isPhoneField ? [FilteringTextInputFormatter.digitsOnly] : [],
        maxLength: isPhoneField ? 11 : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: isPhoneField ? 'Phone Number' : 'Username',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          prefixIcon: Icon(
            isPhoneField ? Icons.phone : Icons.person,
          ),
          errorBorder: OutlineInputBorder( 
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder( 
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        validator: (value) {
          if (isPhoneField && value != null && !RegExp(r'^(?:[+0]9)?[0-9]{10,11}$').hasMatch(value)) {
            return ''; 
          }
          return null; 
        },
      ),
    );
  }
}
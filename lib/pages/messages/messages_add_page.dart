import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/users_all_list_provider.dart';

class AddUserForm extends StatefulWidget {
  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  bool _isTextValid = true; // Bu değişkeni güncelleyeceğiz
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _controller.removeListener(_updateButtonState);
    _controller.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    final textLength = _controller.text.length;
    final isTextValid = (textLength == 10 || textLength == 11) && RegExp(r'^[0-9]+$').hasMatch(_controller.text);

    setState(() {
      _isButtonEnabled = isTextValid;
      _isTextValid = isTextValid; 
    });
  }

  void _handleFocusChange() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find Contacts',
          style: TextStyle(color: Color(0xFFFF8C00)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                focusNode: _focusNode, // FocusNode'u TextFormField'a bağla
                maxLength: 11,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(
                    color: _focusNode.hasFocus ? (_isTextValid ? Colors.blue : Colors.red) : Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                        color: _isTextValid ? Colors.blue : Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                        color: _isTextValid ? Colors.blue : Colors.red),
                  ),
                  counterText: '',
                ),
                onChanged: (value) {
                  _updateButtonState();
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed:() {
                  if(_isButtonEnabled){
                    BlocProvider.of<UserMessagesBloc>(context).add(GetUser(phoneNumber: _controller.text));
                  }else {

                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFF8C00),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text('Find', style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
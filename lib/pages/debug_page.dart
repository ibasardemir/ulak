import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/database_messages_provider.dart';
import 'package:ulak/components/debug/debug_button.dart';


class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

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

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _phonenumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MessageDatabaseBloc(),
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 600,
              child: BlocConsumer<MessageDatabaseBloc, MessageDatabaseState>(
                listener: (context, state) {
                  if (state is MessageDatabseSuccess) {
                  } else if (state is MessageDatabseFailure) {
                  }
                },
                builder: (context, state) {
                  if (state is MessageDatabseLoading) {
                    return const CircularProgressIndicator();
                  }
                  return _buildRegisterForm(context,_usernameController,_phonenumberController);
                },
              ),
            ),
          ),
        ),
      ),
    );
}

Widget _buildRegisterForm(BuildContext context, TextEditingController phoneNumberCr, TextEditingController userNameCr){
  return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 600,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10),
                      child:  const DebugButton(name: "OpenDB")),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child:   TextField(
                        controller: userNameCr,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'username',
                        ),
                      )),
                      Container(
                      margin: const EdgeInsets.all(10),
                      child:   TextField(
                        controller: phoneNumberCr,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'phoneNumber',
                        ),
                      )),
                       Container(
                      margin: const EdgeInsets.all(10),
                      child:   DebugButton(name: "Save User",userNameController: userNameCr,phoneNumberController: phoneNumberCr,)),
                       Container(
                      margin: const EdgeInsets.all(10),
                      child:  const DebugButton(name: "Get All Users")),
            

                      Container(
                      margin: const EdgeInsets.all(10),
                      child:  const DebugButton(name: "DeleteDB")),
                
                
                ],
                
              ))
          ])
        ),
      ),
    );
}}
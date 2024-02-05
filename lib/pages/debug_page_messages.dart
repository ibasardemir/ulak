import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/database_messages_provider.dart';
import 'package:ulak/components/debug/debug_button.dart';


class DebugPageMessages extends StatelessWidget {
  const DebugPageMessages({super.key});

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

  final TextEditingController _senderController = TextEditingController();
  final TextEditingController _recieverController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _senderController.dispose();
    _recieverController.dispose();
    _messageController.dispose();
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
                  return _buildRegisterForm(context,_senderController,_recieverController,_messageController);
                },
              ),
            ),
          ),
        ),
      ),
    );
}

Widget _buildRegisterForm(BuildContext context, TextEditingController fromCr, TextEditingController toCr, TextEditingController messageCr){
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
                        controller: fromCr,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'from',
                        ),
                      )),

                      Container(
                      margin: const EdgeInsets.all(10),
                      child:   TextField(
                        controller: toCr,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'to',
                        ),
                      )),

                      Container(
                      margin: const EdgeInsets.all(10),
                      child:   TextField(
                        controller: messageCr,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'message',
                        ),
                      )),

                       Container(
                      margin: const EdgeInsets.all(10),
                      child:   DebugButton(name: "Save Message",senderController: fromCr,recieverController: toCr,messageController: messageCr,)),
                       Container(
                      margin: const EdgeInsets.all(10),
                      child:  const DebugButton(name: "Get Messages")),
          

                      Container(
                      
                      margin: const EdgeInsets.all(10),
                      child:  const DebugButton(name: "DeleteDB")),
                      Container(
                      height:48,
                      margin: const EdgeInsets.all(10),
                      child:  const DebugButton(name: "Go to Users")),
                
                
                ],
                
              ))
          ])
        ),
      ),
    );
}}
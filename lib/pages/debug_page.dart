import 'package:flutter/material.dart';
import 'package:ulak/components/auth/fixed_button.dart';
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
  @override
  Widget build(BuildContext context) {
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
                      child:  DebugButton(name: "OpenDB")),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child:  const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'username',
                        ),
                      )),
                      Container(
                      margin: const EdgeInsets.all(10),
                      child:  const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'phoneNumber',
                        ),
                      )),
                       Container(
                      margin: const EdgeInsets.all(10),
                      child:  DebugButton(name: "Save User")),
                       Container(
                      margin: const EdgeInsets.all(10),
                      child:  DebugButton(name: "Get All Users")),
                ],
                
              ))
          ])
        ),
      ),
    );
  }
}

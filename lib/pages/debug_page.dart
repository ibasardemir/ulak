import 'package:flutter/material.dart';
import 'package:ulak/components/auth/fixed_button.dart';
import 'package:ulak/components/debug/debug_button.dart';


class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DebugPage();
  }
}

class DebugWidget extends StatefulWidget {
  const DebugWidget({super.key});

  @override
  State<DebugWidget> createState() => _DebugWidgetState();
}

class _DebugWidgetState extends State<DebugWidget> {
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
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(40),
                child: Image.asset(
                    'assets/ulak_logo.jpg',
                    fit: BoxFit.cover, 
                  ),
              )),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10),
                      child:  DebugButton(name: "OpenLocalDB")),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child:  DebugButton(name: "AddUser")),
                    
                ],
                
              ))
          ])
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ulak/components/connection/connect_button.dart';
import 'package:ulak/network/networkservice.dart';

class ConnectionPage extends StatelessWidget {

  const ConnectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: const Text("Connection",
          style: TextStyle(color: const Color(0xFFFF8C00))),
          bottom: const TabBar(
            indicatorColor: const Color(0xFFFF8C00),
            labelColor: const Color(0xFFFF8C00),
            unselectedLabelColor: Color(0xFF7a7a7a),
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.bluetooth_connected),
              ),
              Tab(
                icon: Icon(Icons.connect_without_contact),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            ConnectWithClickWidget(),
            ConnectAuto()
          ],
        ),
      ),
    );
  }
}

class ConnectAuto extends StatefulWidget {
  const ConnectAuto({super.key});

  @override
  State<ConnectAuto> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ConnectAuto> {
  @override
  Widget build(BuildContext context) {
    NetworkService networkService = NetworkService();
    networkService.init();
    return Center(
              child: Text("There is no one nearby"),
            );
  }
}

class ConnectWithClickWidget extends StatefulWidget {
  const ConnectWithClickWidget({super.key});

  @override
  State<ConnectWithClickWidget> createState() => _ConnectWithClickWidgetState();
}

class _ConnectWithClickWidgetState extends State<ConnectWithClickWidget> {
  @override
  Widget build(BuildContext context) {
    NetworkService networkService = NetworkService();
    networkService.init();
    return 
Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(children: <Widget>[
          Center(child: Column(
            children: [
              Container(
                child: Image.asset("assets/connect_logo2.jpg"),
              ),
              Container(
                child: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Find and connect to other devices",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFCCCCCC)
                  ),
                  ),
                ),
              ),
              Container(
                child:  Center(child: ConnectButton(name: "Search")),
              )
            ],
          ),),
        ],)
    );

  }
}
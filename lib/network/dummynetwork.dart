import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_nearby_connections/flutter_nearby_connections.dart";
import "networkservice.dart";
class DummyNetwork extends StatelessWidget{
  const DummyNetwork({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(

      home:Scaffold(
        appBar: AppBar(title: const Text("TEST"),),
        backgroundColor: Colors.white,
        body: const DevList(),),

    );
  }
}
class DevList extends StatefulWidget {
  const DevList({super.key});
  @override
  SDevList createState()=> SDevList();
}
class SDevList extends State<DevList>{
NetworkService networkService = NetworkService();
late StreamSubscription sub;
List<Device> devices = [];
@override
  void initState(){
    super.initState();
    networkService.init();
    StreamSubscription sub = networkService.returnSubscription();
    sub.onData((data) { devices = data;});
  }
  @override
Widget build (BuildContext context){
  return ListView.builder(itemBuilder:(context,index){
        final device = devices[index];
        return Container(
          margin: const EdgeInsets.all(8.0),
          child:Column(children: [
           Row(children: [
            Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(device.deviceName)
              ],),
            ),
           ],),
           const SizedBox(height:8.0),
           const Divider(height: 1,color: Colors.grey,) 
          ],)
        );
      }, 
      itemCount:devices.length);
}
}

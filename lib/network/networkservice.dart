import "dart:async";
import "dart:math";
import "package:flutter_nearby_connections/flutter_nearby_connections.dart";
import "package:ulak/database/auth.dart";
import "package:ulak/database/database.dart";

/*
Network Service: 
  Function sendMessage input:Message object, sends message to the network.
*/

class Message {
  int time;String sender;String receiver; String content;
  Message(this.time, this.sender, this.receiver,this.content);
}
 
class NetworkService {
  bool meth = false;
  Random rand = Random();
  NearbyService nearbyService = NearbyService();
  List<Device> connectedDevices = [];

  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;
  StreamController<List<Device>> controller= StreamController<List<Device>>();
  late Stream stream;
  void init({bool meths = false}) async {
    meth = meths;
    print("object");
    await nearbyService.init(
      serviceType: 'mpconn',
      deviceName: "Fuhrer",//await Authentication().returnPhoneNum(),
      strategy: Strategy.P2P_CLUSTER,
      callback: (isrunning) async {
        if(isrunning){
          print("new call");
          if(meth){
            await nearbyService.startBrowsingForPeers();
            await Future.delayed(const Duration(microseconds: 200));
            for(int i= 0;i<10;i++){
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await nearbyService.startBrowsingForPeers();
            /*await nearbyService.startAdvertisingPeer();
            await nearbyService.startBrowsingForPeers();
            await nearbyService.stopAdvertisingPeer();
            await nearbyService.stopBrowsingForPeers();
            await Future.delayed(const Duration(microseconds: 200));*/
            }
            await nearbyService.stopBrowsingForPeers();
            }
          }
          else {
            await nearbyService.startAdvertisingPeer();
            await nearbyService.startBrowsingForPeers();
            await Future.delayed(const Duration(microseconds: 200));
            for(int i=0;i<10;i++){
              await nearbyService.stopAdvertisingPeer();
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await nearbyService.startAdvertisingPeer();
              await nearbyService.startBrowsingForPeers();
            /*await nearbyService.startBrowsingForPeers();
            await nearbyService.stopBrowsingForPeers();
            await Future.delayed(const Duration(microseconds: 200));*/}
            await nearbyService.stopAdvertisingPeer();
            await nearbyService.stopBrowsingForPeers();
          }
        }
      );
      void sendMessage(Message message, String deviceId)  {
        try {
          nearbyService.sendMessage(deviceId, message.content);
        }
        catch(e) {
          //TODO do this
          print("Eyvah");
        } 
     //TODO do this

  }
      stream = controller.stream;
      subscription = nearbyService.stateChangedSubscription(
        callback: (deviceList) {
          connectedDevices.clear();
          for (Device element in deviceList) { 
            if(element.state==SessionState.notConnected){
            nearbyService.invitePeer(deviceID: element.deviceId, deviceName: element.deviceName);}
            else if(element.state==SessionState.connected){
              connectedDevices.add(element);
            }
          }
          controller.add(connectedDevices);
        }
   );
   
    receivedDataSubscription = nearbyService.dataReceivedSubscription(callback: (data){
      //TODO check this
      for (var dev in connectedDevices){
        if(dev.deviceId!=data.senderDeviceId)sendMessage(data.content,dev.deviceId);
      }
      
      //TODO: Başar Buraya bak
      // *Database.dart message class yolla*
      LocalDB().saveMessage(data);
   });
  
  }
  
  StreamSubscription returnSubscription (){
    return controller.stream.listen((event) { });
   } 
}
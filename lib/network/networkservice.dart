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
  void init() async {
    
    await nearbyService.init(
      serviceType: 'mpconn',
      deviceName: await Authentication().returnPhoneNum(),
      strategy: Strategy.P2P_CLUSTER,
      callback: (isrunning) async {
        if(isrunning){
          if(rand.nextBool()){
            await nearbyService.startAdvertisingPeer();
            await nearbyService.startBrowsingForPeers();
            await nearbyService.stopAdvertisingPeer();
            await nearbyService.stopBrowsingForPeers();
            await Future.delayed(const Duration(microseconds: 200));
            }
          }
          else {
            await nearbyService.startBrowsingForPeers();
            await nearbyService.stopBrowsingForPeers();
            await Future.delayed(const Duration(microseconds: 200));
          }
        }
      );
      void sendMessage(Message message)  {
    
     //TODO do this

  }
      StreamSubscription subscription = nearbyService.stateChangedSubscription(
        callback: (deviceList) {
          connectedDevices.clear();
          for (Device element in deviceList) { 
            if(element.state==SessionState.notConnected){
            nearbyService.invitePeer(deviceID: element.deviceId, deviceName: element.deviceName);}
            else if(element.state==SessionState.connected){
              connectedDevices.add(element);
            }
          }
        }
   ); 
    StreamSubscription receivedDataSubscription = nearbyService.dataReceivedSubscription(callback: (data){
      //TODO check this
      for (var dev in connectedDevices){
        if(dev.deviceId!=data.senderDeviceId)sendMessage(data.content);
      }
      
      //TODO: Başar Buraya bak
      LocalDB().saveMessage("messages", data.name, data);
   });
  
  }
  
}
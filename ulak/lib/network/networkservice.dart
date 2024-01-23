import "dart:async";

import "package:flutter_nearby_connections/flutter_nearby_connections.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:ulak/database.dart";

class Message {
  int time;String sender;String receiver; String content;
  Message(this.time, this.sender, this.receiver,this.content);
}
 
class NetworkService {
  bool meth = false;
  late NearbyService nearbyService;

  void init() async {
     nearbyService = NearbyService();
    
    await nearbyService.init(
      serviceType: 'mpconn',
      deviceName: await Authentication().returnPhoneNum(),
      strategy: Strategy.P2P_CLUSTER,
      callback: (isrunning) async {
        if(isrunning){
  
            await nearbyService.stopAdvertisingPeer();
            await nearbyService.stopBrowsingForPeers();
            await Future.delayed(const Duration(microseconds: 200));
            await nearbyService.startAdvertisingPeer();
            await nearbyService.startBrowsingForPeers();
          }
        }
      );
    StreamSubscription receivedDataSubscription = nearbyService.dataReceivedSubscription(callback: (data){

   });
  }
  
}
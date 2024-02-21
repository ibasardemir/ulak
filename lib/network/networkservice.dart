import "dart:async";
import "dart:math";
import "package:flutter_nearby_connections/flutter_nearby_connections.dart";
import "package:ulak/database/auth.dart";
import "package:shared_preferences/shared_preferences.dart";

import "package:ulak/database/database.dart" as database;

/*
Network Service: 
  Function sendMessage input:Message object, sends message to the network.
*/

class Message {
  int time;
  String sender;
  String receiver;
  String content;
  Message(this.time, this.sender, this.receiver, this.content);
}

class NetworkService {
  bool meth = false;
  Random rand = Random();
  NearbyService nearbyService = NearbyService();
  List<Device> connectedDevices = [];

  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;
  StreamController<List<Device>> controller = StreamController<List<Device>>();
  late Stream stream;
  void init({bool meths = false}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String phoneNumber = pref.getString("phoneNumber") ?? "";
    meth = meths;
    await nearbyService.init(
        serviceType: 'mpconn',
        deviceName: phoneNumber, //await Authentication().returnPhoneNum(),
        strategy: Strategy.P2P_CLUSTER,
        callback: (isrunning) async {
          if (isrunning) {
            print("new call");
            if (meth) {
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await nearbyService.startBrowsingForPeers();
            } else {
              await nearbyService.stopAdvertisingPeer();
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await nearbyService.startAdvertisingPeer();
              await nearbyService.startBrowsingForPeers();
            }
          }
        });
    void sendMessage(Message message, String deviceId) {
      try {
        nearbyService.sendMessage(deviceId, message.content);
      } catch (e) {
        //TODO do this
      }
      //TODO do this
    }

    stream = controller.stream;
    subscription =
        nearbyService.stateChangedSubscription(callback: (deviceList) {
      print("hurray");
      connectedDevices.clear();
      for (Device element in deviceList) {
        if (element.state == SessionState.notConnected) {
          nearbyService.invitePeer(
              deviceID: element.deviceId, deviceName: element.deviceName);
          print(element);
        } else if (element.state == SessionState.connected) {
          print(element);
          connectedDevices.add(element);
        }
      }
      controller.add(connectedDevices);
    });

    receivedDataSubscription =
        nearbyService.dataReceivedSubscription(callback: (data) async {
      //TODO check this
      for (var dev in connectedDevices) {
        if (dev.deviceId != data.senderDeviceId)
          sendMessage(data.content, dev.deviceId);
      }

      //TODO: Başar Buraya bak
      // *Database.dart message class yolla*
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? phoneNumber = prefs.getString("phoneNumber");

      database.Message message = database.Message(
          sender: data.deviceId, reciever: phoneNumber, message: data.message);
      database.LocalDB().saveMessage(message);
    });
  }

  StreamSubscription returnSubscription() {
    return controller.stream.listen((event) {});
  }
}

import "dart:async";
import "dart:convert";
import "dart:io";

import "package:device_info_plus/device_info_plus.dart";
import "package:flutter/material.dart";
import "package:flutter_nearby_connections/flutter_nearby_connections.dart";
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const Home());
    case "browser":
      return MaterialPageRoute(
          builder: (_) =>
              const DevicesListScreen(deviceType: DeviceType.browser));
    case "advertiser":
      return MaterialPageRoute(
          builder: (_) =>
              const DevicesListScreen(deviceType: DeviceType.advertiser));
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Text("Error:no route")));
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: generateRoute,
      initialRoute: '/',
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Ulak")),
        body: Column(children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, "browser");
            },
            child: Container(
                color: Colors.red,
                child: const Center(
                  child: Text("Browser",
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                )),
          )),
          Expanded(
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "advertiser");
                  },
                  child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text("advertiser",
                            style:
                                TextStyle(color: Colors.white, fontSize: 40)),
                      ))))
        ]));
  }
}

enum DeviceType { advertiser, browser }

class DevicesListScreen extends StatefulWidget {
  const DevicesListScreen({super.key, required this.deviceType});

  final DeviceType deviceType;
  @override
  _DevicesListScreenState createState() => _DevicesListScreenState();
}

class _DevicesListScreenState extends State<DevicesListScreen> {
  List<Device> devices = [];
  List<Device> connectedDevices = [];
  late NearbyService nearbyService;
  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;

  bool isInit = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    subscription.cancel();
    receivedDataSubscription.cancel();
    nearbyService.stopBrowsingForPeers();
    nearbyService.stopAdvertisingPeer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deviceType.toString().substring(11).toUpperCase()),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemBuilder: (context, index) {
            final device = widget.deviceType == DeviceType.advertiser
                ? connectedDevices[index]
                : devices[index];
            return Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onTabItemListener(device),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(device.deviceName),
                                Text(getStateName(device.state),
                                    style: TextStyle(
                                        color: getStateColor(device.state)))
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () => _onButtonClicked(device),
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                padding: const EdgeInsets.all(8.0),
                                height: 35,
                                width: 100,
                                color: getButtonColor(device.state),
                                child: Center(
                                  child: Text(getButtonStateName(device.state),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                )))
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                ));
          },
          itemCount: getItemCount()),
    );
  }

  String getStateName(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
        return "disconnected";
      case SessionState.connecting:
        return "waiting";
      default:
        return "connected";
    }
  }

  String getButtonStateName(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
        return "Connect";
      case SessionState.connecting:
        return "Connect";
      default:
        return "Disconnect";
    }
  }

  Color getStateColor(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
        return Colors.black;
      case SessionState.connecting:
        return Colors.grey;
      default:
        return Colors.green;
    }
  }

  Color getButtonColor(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
      case SessionState.connecting:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  _onTabItemListener(Device device) {
    if (device.state == SessionState.connected) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            final myController = TextEditingController();
            return AlertDialog(
                title: const Text("Send message"),
                content: TextField(controller: myController),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        nearbyService.sendMessage(
                            device.deviceId, myController.text);
                        myController.text = "";
                      },
                      child: const Text("Send"))
                ]);
          });
    }
  }

  int getItemCount() {
    if (widget.deviceType == DeviceType.advertiser) {
      return connectedDevices.length;
    } else {
      return devices.length;
    }
  }

  _onButtonClicked(Device device) {
    switch (device.state) {
      case SessionState.notConnected:
        nearbyService.invitePeer(
            deviceID: device.deviceId, deviceName: device.deviceName);
        break;
      case SessionState.connected:
        nearbyService.disconnectPeer(deviceID: device.deviceId);
        break;
      case SessionState.connecting:
        break;
    }
  }

  void init() async {
    nearbyService = NearbyService();
    String devInfo = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      devInfo = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devInfo = iosInfo.localizedModel;
    }
    await nearbyService.init(
        serviceType: 'mpconn',
        deviceName: devInfo,
        strategy: Strategy.P2P_CLUSTER,
        callback: (isrunning) async {
          if (isrunning) {
            if (widget.deviceType == DeviceType.browser) {
              print("inside widgetDeviceType IF");
              await nearbyService.stopBrowsingForPeers();
              print("FLAG 1");
              await Future.delayed(const Duration(microseconds: 200));
              print("FLAG 2");
              nearbyService.startBrowsingForPeers();
              print("FLAG 3");
              print("END widgetDeviceType IF");
            } else {
              print("inside widgetDeviceType ELSE");
              await nearbyService.stopAdvertisingPeer();
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              nearbyService.startAdvertisingPeer();
              nearbyService.startBrowsingForPeers();
              print("END widgetDeviceType ELSE");
            }
          }
        });
    print("Before subs object creation");
    subscription =
        nearbyService.stateChangedSubscription(callback: (deviceList) {
      for (var element in deviceList) {
        print("INSIDE FOR");
        if (Platform.isAndroid) {
          if (element.state == SessionState.connected) {
            nearbyService.stopBrowsingForPeers();
          } else {
            nearbyService.startBrowsingForPeers();
          }
        }
      }
      print("SET STATE");
      setState(() {
        devices.clear();
        devices.addAll(deviceList);
        connectedDevices.clear();
        connectedDevices.addAll(deviceList
            .where((d) => d.state == SessionState.connected)
            .toList());
      });
    });
    print("Recieve Data Subs");
    receivedDataSubscription =
        nearbyService.dataReceivedSubscription(callback: (data) {
      showToast(jsonEncode(data),
          context: context,
          axis: Axis.horizontal,
          alignment: Alignment.center,
          position: StyledToastPosition.bottom);
    });
  }
}

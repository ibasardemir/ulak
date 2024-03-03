import 'package:flutter/material.dart';
import 'package:ulak/network/networkservice.dart';


class ConnectButton extends StatelessWidget {
  final String name;

  const ConnectButton({super.key, required this.name,});

  @override
  Widget build(BuildContext context) {

    double containerWidth = MediaQuery.of(context).size.width * 0.9;

    return SizedBox(
      width: containerWidth,
      height: 60.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFFF8C00), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 2, 
        ),
        onPressed: () {
          NetworkService networkService = NetworkService();
          networkService.init();
        },
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
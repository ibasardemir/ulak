import 'package:flutter/material.dart';
import 'package:ulak/database/database.dart';
import '';

class DebugButton extends StatelessWidget {
  final String name;

  DebugButton({required this.name,});

  @override
  Widget build(BuildContext context) {

    final localDBInstance = LocalDB();
    double containerWidth = MediaQuery.of(context).size.width * 0.9;

    return Container(
      width: containerWidth,
      height: 50.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(0xFFFF8C00), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 2, 
        ),
        onPressed: ()async {
          print("pressed");
          if(name=="OpenDB"){
           print("OpenDB");
           bool result=await localDBInstance.openDB("test");
           
           print(result);
          }
          
          
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
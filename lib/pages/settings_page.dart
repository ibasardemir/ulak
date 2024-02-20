import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  final String name = "Zeynep Nullptr";

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Container(
              child: Column(children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                ClipOval(
                  child: Container(
                    width: 90.0, // Dairenin genişliği
                    height: 90.0, // Dairenin yüksekliği
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.yellow
                        ], // Gradient renkleri
                        begin: Alignment.topLeft, // Gradient başlangıç noktası
                        end: Alignment.bottomRight, // Gradient bitiş noktası
                      ),
                    ),
                    child: Center(
                      child: Text(
                        name[0], // Göstermek istediğiniz harf
                        style: TextStyle(
                          fontSize: 40.0, // Harf boyutu
                          color: Colors.white, // Harf rengi
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  name,
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ]),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: 50.0,),
                  Text("Phone number: "),
                  SizedBox(width: 5.0,),
                  Text("05417837934")
                ],
              )),
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    ));
  }
}

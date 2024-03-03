import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String name = " ";
  String phonenumber = " ";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

 Future<void> _loadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? username=pref.getString("username");
    String? phoneNumber= pref.getString("phoneNumber");
    setState(() {
      name = username ?? "User";
      phonenumber = phoneNumber ?? " ";
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Container(
              child: Column(children: <Widget>[
                const SizedBox(
                  height: 80,
                ),
                ClipOval(
                  child: Container(
                    width: 90.0, // Dairenin genişliği
                    height: 90.0, // Dairenin yüksekliği
                    decoration: const BoxDecoration(
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
                        style: const TextStyle(
                          fontSize: 40.0, // Harf boyutu
                          color: Colors.white, // Harf rengi
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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
        const Divider(
      color: Color.fromARGB(255, 143, 143, 143), // Çizginin rengi
      thickness: 2, // Çizginin kalınlığı
      height: 20, // Çizgi üstü ve altındaki boşluk toplamı
      indent: 20, // Çizginin sol tarafındaki boşluk
      endIndent: 20, // Çizginin sağ tarafındaki boşluk
    ),
        Expanded(
          child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                Row(
                children: [
                  const SizedBox(width: 30.0,),
                  const Icon(Icons.phone,color: Color.fromARGB(255, 146, 145, 145)),
                  const SizedBox(width: 8.0,),
                  const Text("Phone number: ",
                  style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 146, 145, 145)),
                  ),
                  const SizedBox(width: 15.0,),
                  Text(
                  phonenumber,
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
                ],),]
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    ));
  }
}
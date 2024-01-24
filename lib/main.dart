import 'package:flutter/material.dart';

Future<void> main() async {
  runApp( EmergencyApp());
}

class EmergencyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmergencyLoginPage(),
    );
  }
}

class EmergencyLoginPage extends StatefulWidget {
  @override
  _EmergencyLoginPageState createState() => _EmergencyLoginPageState();
}

class _EmergencyLoginPageState extends State<EmergencyLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acil Yardım Giriş'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Kullanıcı Adı',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Şifre',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Giriş butonuna tıklandığında yapılacak işlemler
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Örneğin, giriş doğrulama işlemleri burada yapılabilir.
                // Bu örnek sadece konsola bilgileri yazdırmaktadır.
                print('Kullanıcı Adı: $username');
                print('Şifre: $password');

                // Giriş başarılıysa ana sayfaya yönlendirme
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => EmergencyHomePage()),
                );
              },
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acil Yardım Ana Sayfa'),
      ),
      body: Center(
        child: Text('Hoş Geldiniz!'),
      ),
    );
  }
}
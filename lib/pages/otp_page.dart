import 'package:flutter/material.dart';
import 'package:ulak/components/auth/fixed_button.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OtpScreen();
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Her bir TextField için bir FocusNode
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    // FocusNode'ları temizle
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            child: Column(children: <Widget>[
          const Expanded(child: Center(child: Text('Enter Verification Code'))),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return TextField(
                  focusNode: focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFFF8C00), width: 2.0),
                          borderRadius: BorderRadius.circular(12.0)),
                      focusedBorder: OutlineInputBorder(
                          // Odaklanıldığında kenarlık stili
                          borderSide: const BorderSide(
                              color: Color(0xFFFF8C00), width: 12.0),
                          borderRadius: BorderRadius.circular(8.0)),
                      enabledBorder: OutlineInputBorder(
                        // Odaklanılmamış durum için kenarlık stili
                        borderSide:
                            BorderSide(color: Color(0xFFFF8C00), width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFF8C00)),
                  onChanged: (value) {
                    if (value.length == 1 && index != 5) {
                      focusNodes[index + 1].requestFocus();
                    } else if (value.isEmpty && index != 0) {
                      focusNodes[index - 1].requestFocus();
                    }
                  },
                );
              },
            ),
          ),
          Expanded(child: Center(child: FixedButton(name: "Verify")))
        ])),
      ),
    );
  }
}

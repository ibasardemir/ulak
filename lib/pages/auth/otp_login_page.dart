import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/otp_login_provider.dart';
import 'package:ulak/components/auth/fixed_button.dart';
import 'package:ulak/pages/app/main_app_page.dart';

class OTPLoginPage extends StatelessWidget {
  const OTPLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OtpScreen();
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  List<String> otpValues = List.filled(6, '');

  @override
  void dispose() {
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
                        borderSide: const BorderSide(
                            color: Color(0xFFFF8C00), width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFF8C00)),
                  onChanged: (value) {
                    setState(() {
                      otpValues[index] = value;
                    });
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
          Expanded(
              child: Center(
                  child: BlocConsumer<OTPLoginBloc, OTPLoginState>(
            listener: (context, state) {
              if(state is OTPLoginSuccess){
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()));
              }
            },
            builder: (context, state) {
              String buttonName = "Verify Login";
              if (state is OTPLoginLoading) {
                buttonName = "Verifying...";
              }
              return FixedButton(name: "Verify Login", otpValues: otpValues);
            },
          )))
        ])),
      ),
    );
  }
}

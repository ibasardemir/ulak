import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/register_provider.dart';
import 'package:ulak/components/auth/register_button.dart';
import 'package:ulak/components/auth/register_textfield.dart';
import 'package:ulak/pages/auth/login_page.dart';
import 'package:ulak/pages/auth/otp_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _phonenumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 600,
              child: BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OTPPage()));
                  } else if (state is RegisterFailure) {}
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const CircularProgressIndicator();
                  }
                  return _buildRegisterForm(
                      context, _usernameController, _phonenumberController);
                },
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildRegisterForm(BuildContext context, TextEditingController name,
      TextEditingController phoneNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
                  child: RegisterTextField(
                    iconName: "user",
                    textController: name,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
                  child: RegisterTextField(
                    iconName: "phone",
                    textController: phoneNumber,
                  ),
                ),
                Column(children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
                    child: RegisterButton(
                      name: 'Register',
                      userNameController: name,
                      phoneNumberController: phoneNumber,
                      registerBloc: BlocProvider.of<RegisterBloc>(context),
                      formKey: _formKey,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          text: "Already have an acount?       "),
                      TextSpan(
                          text: 'Login',
                          style: const TextStyle(color: Color(0xFFFF8C00)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            })
                    ])),
                  )
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/login_provider.dart';
import 'package:ulak/components/auth/login_button.dart';
import 'package:ulak/components/auth/register_textfield.dart';
import 'package:ulak/pages/auth/otp_login_page.dart';
import 'package:ulak/pages/auth/otp_page.dart';
import 'package:ulak/pages/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OTPLoginPage()));
                  } else if (state is LoginFailure) {}
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
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
                const SizedBox(
                  height: 110,
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
                    child: LoginButton(
                      name: 'Login',
                      userNameController: name,
                      phoneNumberController: phoneNumber,
                      loginBloc: BlocProvider.of<LoginBloc>(context),
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
                          text: "Don't have an acount?       "),
                      TextSpan(
                          text: 'Sign up',
                          style: const TextStyle(color: Color(0xFFFF8C00)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()));
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

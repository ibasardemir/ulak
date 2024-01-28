import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/register_provider.dart';
import 'package:ulak/components/register_button.dart';
import 'package:ulak/components/register_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _phonenumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 600,
              child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    // Kullanıcı başarıyla kaydoldu
                  } else if (state is LoginFailure) {
                    // Kayıt başarısız oldu
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    // Yükleme göstergesi
                    return const CircularProgressIndicator();
                  }
                  return _buildRegisterForm(context,_usernameController,_phonenumberController);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context, TextEditingController name, TextEditingController phoneNumber) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
          child: Column(
            children: <Widget>[
              // Kullanıcı Adı Giriş Alanı
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
                child: RegisterTextField(
                  iconName: "user",
                  textController: name,
                ),
              ),
              // Telefon Numarası Giriş Alanı
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
                child: RegisterTextField(
                  iconName: "phone",
                  textController: phoneNumber,
                ),
              ),
              // Kayıt Ol Butonu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
                child: RegisterButton(
                  name: 'Register',
                  userNameController: name,
                  phoneNumberController: phoneNumber,
                  loginBloc: BlocProvider.of<LoginBloc>(context),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}}
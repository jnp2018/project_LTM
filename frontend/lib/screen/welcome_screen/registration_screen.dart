import 'package:flutter/material.dart';
import 'package:frontend/common/notification.dart';
import 'package:frontend/provider/user_state.dart';
import 'package:frontend/screen/home.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../common/buttonlogin_registration.dart';
import '../../configs/style_configs.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late IO.Socket socket;
  String user = "";
  String passWord = "";

  Future registe() async {
    await context.read<UserState>().registe(user, passWord);
    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  user = value;
                },
                decoration:
                    kTextfiledecoration.copyWith(hintText: 'username')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                onChanged: (value) {
                  passWord = value;
                },
                decoration: kTextfiledecoration.copyWith(
                    hintText: 'password')),
            SizedBox(
              height: 24.0,
            ),
            buttonlogin_registration(
              coulour: Colors.blueAccent,
              tittle: 'Register',
              onPress: () async {
                registe();
              },
            )
          ],
        ),
      ),
    );
  }
}

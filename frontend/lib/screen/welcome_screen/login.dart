import 'package:flutter/material.dart';
import 'package:frontend/common/notification.dart';
import 'package:frontend/provider/user_state.dart';
import 'package:frontend/screen/home.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../common/buttonlogin_registration.dart';
import '../../configs/style_configs.dart';

class Login extends StatefulWidget {
  static String id = "login_screen";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  String user = "";
  String pass = "";
  Future login(String username, String password) async {
    if (await context.read<UserState>().login(username, password)) {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.id, (route) => false);
    } else {
      alert(context, "Đăng nhập không thành công");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
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
                        pass = value;
                      },
                      decoration:
                          kTextfiledecoration.copyWith(hintText: 'password.')),
                  SizedBox(
                    height: 24.0,
                  ),
                  buttonlogin_registration(
                    coulour: Colors.lightBlueAccent,
                    tittle: 'Log In',
                    onPress: () async {
                      try {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                        setState(() {
                          isLoading = true;
                        });
                        login(user, pass).then((value) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
            Visibility(
                visible: isLoading,
                child: Material(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(child: CircularProgressIndicator()),
                ))
          ],
        ),
      ),
    );
  }
}

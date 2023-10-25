import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:frontend/provider/audio_state.dart';
import 'package:frontend/provider/user_state.dart';
import 'package:frontend/screen/about_screen.dart';
import 'package:frontend/screen/admin/admin_screen.dart';
import 'package:frontend/screen/home.dart';
import 'package:frontend/screen/music_screen/list_music_screen.dart';
import 'package:frontend/screen/welcome_screen/login.dart';
import 'package:frontend/screen/welcome_screen/registration_screen.dart';
import 'package:frontend/screen/welcome_screen/welcome.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'configs/basic_configs.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserState()),
      ChangeNotifierProvider(create: (_) => AudioState())
    ],
    builder: (context, child) {
      context.read<UserState>().connectAndListen();
      return const MyApp();
    },
  ));
}


//TODO innit Hive storage
Future setupHive() async {
  Directory documents = await getApplicationDocumentsDirectory();
  Hive.init(documents.path);
  await Hive.openBox(boxUserSettingName);

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
@override
  void initState() {
    super.initState();
    offFlashScreen();
  }

   void offFlashScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        home: HomeScreen(),
        routes: {
          WelcomeScreen.id: (BuildContext ctx) => WelcomeScreen(),
          HomeScreen.id: (BuildContext ctx) => HomeScreen(),
          Login.id: (BuildContext ctx) => Login(),
          RegistrationScreen.id: (BuildContext ctx) => RegistrationScreen(),
          ListMusicScreen.id: (BuildContext ctx) => ListMusicScreen(),
          AboutScreen.id: (BuildContext ctx) => AboutScreen(),
          AdminScreen.id: (BuildContext ctx) => AdminScreen()
        },
      ),
    );
  }
}

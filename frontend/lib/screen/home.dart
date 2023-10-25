import 'package:flutter/material.dart';
import 'package:frontend/provider/user_state.dart';
import 'package:frontend/screen/music_screen/list_music_screen.dart';
import 'package:frontend/screen/welcome_screen/welcome.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<UserState, String>(
      builder: (context, value, child) {
        if (value != "") {
          return ListMusicScreen();
        }
        return WelcomeScreen();
      },
      selector: (ctx, state) => state.role,
      shouldRebuild: (previous, next) => true,
    );
  }
}

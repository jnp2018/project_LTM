import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/provider/audio_state.dart';
import 'package:frontend/provider/user_state.dart';
import 'package:frontend/screen/home.dart';
import 'package:frontend/screen/music_screen/list_music_screen.dart';
import 'package:provider/provider.dart';

import '../custom_icons_icons.dart';
import '../screen/about_screen.dart';
import '../screen/admin/admin_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        color: Colors.black38.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset("assets/images/hinh.jpg"),
                Positioned(
                  top: 0,
                  left: 0,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                             AssetImage("assets/images/logo.png"),
                          backgroundColor: Colors.pinkAccent,
                          radius: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "thinh",
                                // context.read<UserState>().nameUser,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Selector<UserState, String>(
              builder: ((context, value, child) {
                if (value == "admin") {
                  return InkWell(
                    onTap: (() {
                      Navigator.pushNamed(
                          context, AdminScreen.id,);
                    }),
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 20, left: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.white.withOpacity(0.2)))),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.admin_panel_settings_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Admin",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  );
                }return SizedBox();
              }),
              selector: (ctx, state) => state.role,
            ),
            InkWell(
              onTap: (() {
                Navigator.pushNamedAndRemoveUntil(
                    context, ListMusicScreen.id, (route) => false);
              }),
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 20, left: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.2)))),
                child: Row(
                  children: const [
                    Icon(
                      Icons.music_note_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Music",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     // context.read<AudioState>().pauseMusic();
            //     // Navigator.pushNamedAndRemoveUntil(
            //     //     context, ListVideoScreen.id, (route) => false);
            //   },
            //   child: Container(
            //     height: 50,
            //     margin: EdgeInsets.only(top: 20, left: 10),
            //     decoration: BoxDecoration(
            //         border: Border(
            //             bottom:
            //                 BorderSide(color: Colors.white.withOpacity(0.2)))),
            //     child: Row(
            //       children: const [
            //         Icon(
            //           Icons.video_collection_outlined,
            //           color: Colors.white,
            //           size: 35,
            //         ),
            //         SizedBox(
            //           width: 20,
            //         ),
            //         Text(
            //           "Video",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.w400,
            //               fontSize: 20),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                context.read<AudioState>().pauseMusic();
                Navigator.pushNamedAndRemoveUntil(
                    context, AboutScreen.id, (route) => false);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 20, left: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.2)))),
                child: Row(
                  children: const [
                    Icon(
                      Icons.fiber_manual_record,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "About",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                context.read<AudioState>().stop();
                context.read<AudioState>().cleanAll();
                context.read<UserState>().logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.id, (route) => false);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 20, left: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.2)))),
                child: Row(
                  children: const [
                    Icon(
                      CustomIcons.arrow_in_left,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Sign out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

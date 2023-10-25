import 'package:flutter/material.dart';
import 'package:frontend/configs/style_configs.dart';

import '../common/drawer.dart';
import '../common/dummy_data.dart';

class AboutScreen extends StatefulWidget {
  static const String id = "about_screen";
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBg,
      drawer: DrawerScreen(),
      appBar: AppBar(
        backgroundColor: kColorBg,
        centerTitle: true,
        title: Text(
          "About",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 12,right: 13),
        child: ListView(children: [
          Padding(
            padding: EdgeInsets.only(top: 20,bottom: 20),
            child: Text(
              'Make ideas grow',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Text(
            'Nhằm phục vụ mục đích môn học và nhu cầu nghe nhạc của các bạn học sinh hiện nay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, bottom: 10),
            child: Text(
              "Team",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 20,left: 20,top: 20, bottom: index ==data.length-1? 10 : 0),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/Chang.png'),
                        radius: 45,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            data[index].fullName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            data[index].msv,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}

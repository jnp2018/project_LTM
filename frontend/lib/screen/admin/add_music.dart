import 'package:flutter/material.dart';
import 'package:frontend/models/music.dart';
import 'package:frontend/provider/user_state.dart';
import 'package:provider/provider.dart';

import '../../common/notification.dart';
import '../../configs/style_configs.dart';

class AddMusic extends StatefulWidget {
  const AddMusic({super.key});

  @override
  State<AddMusic> createState() => _AddMusicState();
}

class _AddMusicState extends State<AddMusic> {
  String name ='';
  String describe = "";
  String image = "";
  String link = "";

  void addMp3()async{
    Music data = Music(id: 0, name: name, des: describe, image: image, url: link);
    await context.read<UserState>().addMusic(data).then((value) => alert(context, "tạo bài hát thành công"));
    // MusicModel data = MusicModel(name: name, image: image, des: describe, url: link, like: []);
    // await context.read<UserState>().addmp3(data).then((value) => alert(context, "tạo bài hát thành công"));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kColorBg2,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              style: TextStyle(fontSize: 14, color: kColorWhite),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "   Name",
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  describe = value;
                });
              },
              style: TextStyle(fontSize: 14, color: kColorWhite),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "   Describe",
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  image = value;
                });
              },
              style: TextStyle(fontSize: 14, color: kColorWhite),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "   Image",
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  link = value;
                });
              },
              style: TextStyle(fontSize: 14, color: kColorWhite),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "   Link",
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                addMp3();
              },
              child: Container(
                child: Center(child: const Text("Thêm")),
                color: Colors.red,
                height: 50,
                width: 150,
              ),
            )
          ],
        ),
      ),
    );

  }
}
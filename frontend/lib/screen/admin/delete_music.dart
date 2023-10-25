import 'package:flutter/material.dart';
import 'package:frontend/configs/style_configs.dart';
import 'package:frontend/models/music.dart';
import 'package:frontend/provider/user_state.dart';
import 'package:provider/provider.dart';

class DeleteMusic extends StatefulWidget {
  const DeleteMusic({super.key});

  @override
  State<DeleteMusic> createState() => _DeleteMusicState();
}

class _DeleteMusicState extends State<DeleteMusic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Selector<UserState, List<Music>>(
        builder: (context, value, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Container(
                height: 75,
                width: double.infinity,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(color: kColorBg2),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(value[index].name, style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          ),),
                        )),
                    Expanded(
                        child: Center(
                      child: GestureDetector(
                        onTap: (){
                          context.read<UserState>().deleteMusic(value[index]);
                        },
                        child: Icon(Icons.delete, color: Colors.white,)),
                    ))
                  ],
                ),
              );
            },
          );
        },
        selector: (context, state) => state.dataMusic,
        shouldRebuild: (previous, next) => true,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/models/music.dart';
import 'package:frontend/provider/audio_state.dart';
import 'package:provider/provider.dart';

import '../../common/comment_music.dart';
import '../../configs/style_configs.dart';

class MusicScreen extends StatefulWidget {
  Music musicModel;
  MusicScreen(this.musicModel, {Key? key}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  bool isPlay = false;
  bool isLoadDuration = false;
  bool isLike = false;

  @override
  void initState() {
    setDuration();
    super.initState();
  }

  void setDuration() async {
    context.read<AudioState>().durationMusic().then((value) {
      setState(() {
        isLoadDuration = true;
      });
    });
    context.read<AudioState>().positionMusic();
    context.read<AudioState>().oncomlete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBg,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kColorBg,
        title: Text(widget.musicModel.name),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 12, right: 13, top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              backgroundImage: NetworkImage(widget.musicModel.image),
              radius: 120,
            ),
            Column(
              children: [
                Text(
                  widget.musicModel.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 28),
                ),
                Text(
                  widget.musicModel.des,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context
                          .watch<AudioState>()
                          .posision
                          .toString()
                          .split(".")[0],
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    context.watch<AudioState>().duration == Duration.zero
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator())
                        : Text(
                            context
                                .watch<AudioState>()
                                .duration
                                .toString()
                                .split(".")[0],
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                  ),
                  child: Slider(
                    value: context
                        .watch<AudioState>()
                        .posision
                        .inSeconds
                        .toDouble(),
                    onChanged: (value) {
                      context
                          .read<AudioState>()
                          .seekMusic(Duration(seconds: value.toInt()));
                    },
                    max: context
                                .watch<AudioState>()
                                .duration
                                .inSeconds
                                .toDouble() ==
                            0
                        ? 1
                        : context
                                .watch<AudioState>()
                                .duration
                                .inSeconds
                                .toDouble() +
                            0.5,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: (() {
                      if (isLoadDuration == true) {
                        context.read<AudioState>().back15();
                      }
                    }),
                    child: Image.asset("assets/images/back15.png")),
                InkWell(
                    onTap: () {
                      if (isLoadDuration == true) {
                        context.read<AudioState>().chageIsplay();
                        if (!context.read<AudioState>().isPlay) {
                          context.read<AudioState>().pauseMusic();
                        } else {
                          context.read<AudioState>().remsumeMusic();
                        }
                      }
                    },
                    child: context.read<AudioState>().isPlay
                        ? Image.asset("assets/images/pause.png")
                        : Image.asset("assets/images/play.png")),
                InkWell(
                    onTap: () {
                      context.read<AudioState>().forward15();
                    },
                    child: Image.asset("assets/images/forward15.png")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // if (isLike) {
                    //   updateLike(false);
                    // } else {
                    //   updateLike(true);
                    // }
                    // setState(() {
                    //   isLike = !isLike;
                    // });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isLike
                        ? Colors.pink
                        : Colors.white,
                    size: 35,
                  ),
                  color: Colors.amber,
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CommentMusic(widget.musicModel.id);
                      },
                    );
                  },
                  icon: Icon(
                    Icons.comment,
                    color: Colors.white,
                    size: 35,
                  ),
                  color: Colors.amber,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

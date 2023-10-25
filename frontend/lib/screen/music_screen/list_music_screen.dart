import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:frontend/models/music.dart';
import 'package:frontend/provider/audio_state.dart';
import 'package:frontend/provider/user_state.dart';
import 'package:frontend/screen/music_screen/list_item_music.dart';
import 'package:frontend/screen/music_screen/music_screen.dart';
import 'package:provider/provider.dart';

import '../../common/drawer.dart';
import '../../configs/style_configs.dart';

class ListMusicScreen extends StatefulWidget {
  static const String id = "music_screen";
  const ListMusicScreen({Key? key}) : super(key: key);

  @override
  State<ListMusicScreen> createState() => _ListMusicScreenState();
}

class _ListMusicScreenState extends State<ListMusicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBg,
      drawer: DrawerScreen(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kColorBg,
        title: Text(
          "Music",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Selector<UserState, bool>(
              shouldRebuild: (previous, next) => true,
              builder: (context, value, child) {
                if (!value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Selector<UserState,List<Music>>(
                    builder: (ctx, a, child) {
                      if (a.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: a.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  context.read<AudioState>().clean(a[index].url,
                                      a[index].image, a[index].name);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MusicScreen(a[index])));
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: index == 0 ? 20 : 0),
                                    child: ListItemMusic(a[index])));
                          },
                        );
                      }
                    },
                    selector: (ctx, state) => state.dataMusic,
                    shouldRebuild: (previous, next) => true,
                  );
                }
              },
              selector: (context, state) => state.isFetchData,
            )),
            context.watch<AudioState>().pathUrl != ""
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    color: kColorBg2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2,
                          width: double.infinity,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              overlayShape: SliderComponentShape.noOverlay,
                              thumbShape:
                                  RoundSliderThumbShape(enabledThumbRadius: 0),
                            ),
                            child: Slider(
                              max: context
                                      .watch<AudioState>()
                                      .duration
                                      .inSeconds
                                      .toDouble() +
                                  0.2,
                              value: context
                                  .watch<AudioState>()
                                  .posision
                                  .inSeconds
                                  .toDouble(),
                              onChanged: ((value) {}),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1 - 2,
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    context.watch<AudioState>().imageUrl),
                                backgroundColor: Colors.transparent,
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  margin: EdgeInsets.all(15),
                                  child: Text(
                                    context.watch<AudioState>().name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: kColorWhite, fontSize: 20),
                                  )),
                              Expanded(
                                child: Center(
                                  child: InkWell(
                                      onTap: () {
                                        context
                                            .read<AudioState>()
                                            .chageIsplay();
                                        if (!context
                                            .read<AudioState>()
                                            .isPlay) {
                                          context
                                              .read<AudioState>()
                                              .pauseMusic();
                                        } else {
                                          context
                                              .read<AudioState>()
                                              .remsumeMusic();
                                        }
                                      },
                                      child: context.read<AudioState>().isPlay
                                          ? Image.asset(
                                              "assets/images/pause.png",
                                              height: 40,
                                              width: 40,
                                            )
                                          : Image.asset(
                                              "assets/images/play.png",
                                              height: 40,
                                              width: 40,
                                            )),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ))
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

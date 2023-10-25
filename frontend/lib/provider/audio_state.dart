import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:frontend/models/music.dart';

class AudioState extends ChangeNotifier {
  Music? data ;
  final player = AudioPlayer();
  String pathUrl = "";
  Duration duration = Duration.zero;
  Duration posision = Duration.zero;
  bool isPlay = false;
  String imageUrl = "";
  String name = "";

  chageIsplay(){
    isPlay = !isPlay;
    notifyListeners();
  }

  cleanAll(){
    pathUrl = "";
    name = "";
    imageUrl="";
    notifyListeners();
  }

  Future playMusic(String url) async {
    pathUrl = url;
    await player.play(UrlSource(url));
  }

  Future pauseMusic() async {
    isPlay = false;
    notifyListeners();
    await player.pause();
  }

  Future remsumeMusic() async{
    isPlay = true;
    notifyListeners();
    await player.resume();
  }

  Future stop() async{
    isPlay = false;
    await player.stop();
  }

  void positionMusic() {
    player.onPositionChanged.listen((event) { 
      posision = event;
      notifyListeners();
    });
  }


  Future durationMusic() async{
    player.onDurationChanged.listen((event) {
      duration = event;
      notifyListeners();
    });
  }

  Future oncomlete() async{
    player.onPlayerComplete.listen((event) {
      player.seek(Duration.zero);
      isPlay = false;
      player.pause();
      notifyListeners();
    });
  }

  void seekMusic(Duration value){
    player.seek(value);
    notifyListeners();
  }

  Future clean(String url, String image, String nameUrl) async {
    if(nameUrl != name){
      isPlay = true;
      imageUrl = image;
      name = nameUrl;
      notifyListeners();
      await player.stop();
      await playMusic(url);
    }
  }

  Future back15() async{
    if(posision.inSeconds < 15){
      await player.seek(Duration(seconds: 0));
    }else{
      await player.seek(posision - Duration(seconds: 15));
    }
  }

  Future forward15() async{
    if(duration.inSeconds - posision.inSeconds < 15){
      posision = Duration.zero;
      isPlay = false;
      notifyListeners();
      await player.pause();
      await player.seek(Duration.zero);
    }else{
      await player.seek(posision + Duration(seconds: 15));
    }
  }
}

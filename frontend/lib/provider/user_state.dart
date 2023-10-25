import 'dart:convert';
import 'package:frontend/common/dummy_data.dart';
import 'package:frontend/models/comment.dart';
import 'package:frontend/models/music.dart';
import 'package:frontend/models/send_comment.dart';
import 'package:frontend/models/user.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  late IO.Socket socket;
  List<Music> dataMusic = [];
  List<Comment> dataComment = [];
  bool isFetchData = false;
  String role = "";
  String userName = "";
  int idUser = 0;

  void connectAndListen() {
    socket = IO.io('http://192.168.153.114:3000',
        IO.OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((_) {
      print('connect');
    });
    dataMusic.clear();
    socket.on("music", (data) {
      for (var music in data) {
        print(music);
        dataMusic.add(Music.fromMap(music));
      }
      isFetchData = true;
      notifyListeners();
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  Future login(String user, String passWord) async {
    User a = User(user: user, password: passWord);
    socket.emit("login", a.toJson());
    socket.on("returnLogin", (data) {
      for (var i in data) {
        role = i["role"] ?? "";
        notifyListeners();
      }
      print(role);
    });
    userName = user;
    socket.emit("getId", userName);
    socket.on("getIdServer", (data){
      idUser = data[0]["iduser"];
      print(idUser);
    });
    await Future.delayed(Duration(seconds: 3));
    if (role != "") {
      return true;
    }
    return false;
  }

  Future registe(String user, String password) async {
    User a = User(user: user, password: password);
    socket.emit("registe", a.toNewUser());
    role = "user";
    notifyListeners();
  }

  Future logout() async {
    role = "";
    notifyListeners();
  }

  Future addMusic(Music data) async {
    socket.emit("addMusic", data.toJson());
    dataMusic.add(data);
    notifyListeners();
  }

  Future deleteMusic(Music data) async {
    socket.emit("deleteMusic", data.name);
    dataMusic.remove(data);
    notifyListeners();
  }

  Future getCmt(int id) async {
    socket.emit("comment", id);
    socket.on("cmt", (data) {
      dataComment.clear();
      print(data);
      for (var i in data) {
        dataComment.add(Comment.fromMap(i));
      }
    });
    await Future.delayed(Duration(seconds: 2));
    return dataComment;
  }


  Future putCmt(int idMusic, String text )async{
    SendComment a = SendComment(idUSer: idUser, idMusic: idMusic, comment: text);
    socket.emit("putComment",a.toJson());
  }
}

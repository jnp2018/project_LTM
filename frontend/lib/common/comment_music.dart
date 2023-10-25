import 'package:flutter/material.dart';
import 'package:frontend/models/comment.dart';
import 'package:frontend/provider/user_state.dart';
import 'package:provider/provider.dart';

import '../configs/style_configs.dart';

class CommentMusic extends StatefulWidget {
  final int id;
  const CommentMusic(
    this.id,
    {super.key});

  @override
  State<CommentMusic> createState() => _CommentMusicState();
}

class _CommentMusicState extends State<CommentMusic> {
  bool isLoading = true;
  String text ="";
   final TextEditingController _controller = TextEditingController();
   List<Comment> data = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
   data = await context.read<UserState>().getCmt(widget.id);
    setState(() {
      isLoading = false;
    });
  }


  putComment() async{
    await context.read<UserState>().putCmt(widget.id,text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: kColorBg2.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10.0)),
          margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.7,
          width: double.infinity,
          child: Builder(
            builder: (context) {
              if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              "${data[index].userName}: ",
                              style:
                                  TextStyle(color: kColorWhite, fontSize: 24),
                            ),
                            Text(
                              data[index].cmt,
                              style:
                                  TextStyle(color: kColorWhite, fontSize: 20),
                            )
                          ],
                        );
                      },
                      itemCount: data.length,
                    ),
                  ),
                  Expanded(
                      child: Row(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: _controller,
                        onChanged: (value){
                          text = value;
                        },
                        style: TextStyle(fontSize: 14, color: kColorWhite),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
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
                    ),
                    Expanded(
                        child: IconButton(
                      onPressed: () {
                        _controller.clear();
                        setState(() {
                          data.add(Comment(userName: context.read<UserState>().userName, cmt: text));
                        });
                        putComment();
                      },
                      icon: Icon(Icons.send),
                      color: kColorWhite,
                    ))
                  ]))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

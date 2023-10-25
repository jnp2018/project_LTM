class Comment{
  late String userName;
  late String cmt;
  Comment({
    required this.userName,
    required this.cmt
  });

  Comment.fromMap(Map<String,dynamic> data){
    userName = data["username"];
    cmt = data["comment"];
  }
}
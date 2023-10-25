class SendComment{
  late int idUSer;
  late int idMusic;
  late String comment;

  SendComment({
    required this.idUSer,
    required this.idMusic,
    required this.comment
  });

  Map<String, dynamic> toJson() => {
    "idUser":idUSer,
    "idMusic": idMusic,
    "comment": comment,
    };
}
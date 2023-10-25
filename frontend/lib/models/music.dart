class Music{
  late int id;
  late String name;
  late String des;
  late String image;
  late String url;

  Music({
    required this.id,
    required this.name,
    required this.des,
    required this.image,
    required this.url
  });

  Music.fromMap(Map<String,dynamic> data){
    id = data["id"];
    name = data["name"];
    des = data["des"];
    image = data["image"];
    url = data["url"];
  }

  Map<String, dynamic> toJson() => {
    "name":name,
    "des": des,
    "image": image,
    "link": url
    };
}
class User {
  late String user;
  late String password;
  late String role;

  User({required this.user, required this.password});

  User.fromMap(Map<String, dynamic> data) {
    user = data["user"];
    password = data["password"];
  }

  User.fromToUser(Map<String, dynamic> data){
    role = data["role"];
  }

  Map<String, dynamic> toJson() => {"user": user, "password": password};

  Map<String, dynamic> toNewUser() => {
    "user": user,
    "password": password,
    "role": "user"
  };
}

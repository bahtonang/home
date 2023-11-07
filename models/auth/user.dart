import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final bool error;
  final String message;
  final User user;
  final String accessToken;

  LoginModel({
    required this.error,
    required this.message,
    required this.user,
    required this.accessToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        error: json["error"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "user": user.toJson(),
        "access_token": accessToken,
      };
}

class User {
  final String pid;
  final String nama;
  final String gedung;
  final String kodebagian;

  User({
    required this.pid,
    required this.nama,
    required this.gedung,
    required this.kodebagian,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        pid: json["pid"],
        nama: json["nama"],
        gedung: json["gedung"],
        kodebagian: json["kodebagian"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "nama": nama,
        "gedung": gedung,
        "kodebagian": kodebagian,
      };
}

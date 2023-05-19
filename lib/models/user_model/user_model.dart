import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
     this.image,
    required this.id,
    required this.name,
    required this.email,
  });

  String? image;
  String name;
  String email;
  String id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        image: json["image"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
      };


      UserModel copyWith({
    String? name,image, 
  }) =>
      UserModel(
          image: image??this.image,
          id: id,
          name: name??this.name,
          email: email,
          );
}

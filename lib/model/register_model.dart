import 'dart:convert';

RegistrasiModel userModelFromJson(String str) =>
    RegistrasiModel.fromJson(json.decode(str));

String userModelToJson(RegistrasiModel data) => json.encode(data.toJson());

class RegistrasiModel {
  String? id;
  String? name;
  String? email;
  String? password;

  RegistrasiModel({this.id, this.name, this.email, this.password});

  RegistrasiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

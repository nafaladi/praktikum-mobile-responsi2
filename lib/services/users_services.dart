import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nafal/model/user_model.dart';

class UserServices {
  Future<UserModel?> login(String email, String password) async {
    final response = await http.post(
        Uri.parse("http://192.168.100.58/prakmobile/login.php"),
        body: {"email": email, "password": password},
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> result = json.decode(response.body);

      if (result["success"] == true) {
        UserModel user = UserModel.fromJson(result["data"]);
        return user;
      } else {
        return null;
      }
    }

    return null;
  }

}

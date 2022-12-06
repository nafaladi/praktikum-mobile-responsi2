import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nafal/model/register_model.dart';
class RegisterServices {
  Future<RegistrasiModel?> register(String name, String email, String password) async {
    final response = await http.post(
        Uri.parse("http://192.168.100.58/prakmobile/register.php"),
        body: {"name":name,"email": email, "password": password},
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> result = json.decode(response.body);

      if (result["success"] == true) {
        RegistrasiModel user = RegistrasiModel.fromJson(result["data"]);
        return user;
      } else {
        return null;
      }
    }

    return null;
  }


}

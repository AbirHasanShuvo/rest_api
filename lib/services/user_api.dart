import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restful_api/model/user.dart';
import 'package:restful_api/model/user_dob.dart';
import 'package:restful_api/model/user_location.dart';

class UserApi {
  static Future<List<User>> fetchUser() async {
    //without static it can't be call
    // print('fetch user');
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;

    final users = results.map((e) {
      return User.fromMap(e);
    }).toList();

    return users;
  }
}

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
      final name = Username(
          title: e['name']['title'],
          first: e['name']['first'],
          last: e['name']['last']);

      final date = e['dob']['date'];

      final dob = UserDob(date: DateTime.parse(date), age: e['dob']['age']);

      final street = LocationStreet(
          name: e['location']['street']['name'],
          number: e['location']['street']['number']);
      final coordinate = LocationCoordinate(
          latitude: e['location']['coordinates']['latitude'],
          longitude: e['location']['coordinates']['longitude']);
      final timezone = LocationTimezoneCoordinate(
          offset: e['location']['timezone']['offset'],
          description: e['location']['timezone']['description']);
      final location = UserLocation(
          city: e['location']['city'],
          state: e['location']['state'],
          country: e['location']['country'],
          postcode: e['location']['postcode']
              .toString(), //some postal codes are string
          street: street,
          coordinate: coordinate,
          timezone: timezone);

      return User(
          gender: e['gender'],
          email: e['email'],
          phone: e['phone'],
          cell: e['cell'],
          nat: e['nat'],
          name: name,
          dob: dob,
          location: location);
    }).toList();

    return users;
  }
}

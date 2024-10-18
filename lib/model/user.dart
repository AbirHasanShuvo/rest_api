import 'package:restful_api/model/user_dob.dart';
import 'package:restful_api/model/user_location.dart';
import 'package:restful_api/model/user_picture.dart';

class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final Username name;
  final UserDob dob;
  final UserLocation location;
  final UserPicture picture;

  User(
      {required this.gender,
      required this.email,
      required this.phone,
      required this.cell,
      required this.nat,
      required this.name,
      required this.dob,
      required this.location,
      required this.picture});

  factory User.fromMap(Map<String, dynamic> e) {
    final name = Username(
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last']);

    final date = e['dob']['date'];

    final dob = UserDob(date: DateTime.parse(date), age: e['dob']['age']);

    // final dob =
    //     UserDob.fromMap(e['dob']); //like this dob i can make my code better

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
      postcode:
          e['location']['postcode'].toString(), //some postal codes are string
      street: street,
      coordinate: coordinate,
      timezone: timezone,
    );

    final picture = UserPicture(
        large: e['picture']['large'],
        medium: e['picture']['medium'],
        thumbnail: e['picture']['thumbnail']);

    return User(
        gender: e['gender'],
        email: e['email'],
        phone: e['phone'],
        cell: e['cell'],
        nat: e['nat'],
        name: name,
        dob: dob,
        location: location,
        picture: picture);
  }

  String get fullName {
    return '${name.title} ${name.first} ${name.last}';
  }
}

class Username {
  final String title;
  final String first;
  final String last;

  Username({required this.title, required this.first, required this.last});
}

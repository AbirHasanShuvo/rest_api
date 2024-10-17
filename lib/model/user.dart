import 'package:restful_api/model/user_dob.dart';
import 'package:restful_api/model/user_location.dart';

class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final Username name;
  final UserDob dob;
  final UserLocation location;

  User(
      {required this.gender,
      required this.email,
      required this.phone,
      required this.cell,
      required this.nat,
      required this.name,
      required this.dob,
      required this.location});

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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:restful_api/model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: fetchUser),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'REST API call',
          style: GoogleFonts.merriweather(fontSize: 19),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final email = user.email;
          // final name = user['name']['title'] +
          //     " " +
          //     " " +
          //     user['name']['first'] +
          //     " " +
          //     user['name']['last'];
          // final imageUrl = user['picture']['thumbnail'];
          return ListTile(
            title: Text(user.name.first, style: GoogleFonts.lato()),
            subtitle: Text(user.phone),
          );
        },
      ),
    );
  }

  void fetchUser() async {
    // print('fetch user');
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;

    final transformed = results.map((e) {
      final name = Username(
          title: e['name']['title'],
          first: e['name']['first'],
          last: e['name']['last']);

      return User(
          gender: e['gender'],
          email: e['email'],
          phone: e['phone'],
          cell: e['cell'],
          nat: e['nat'],
          name: name);
    }).toList();

    setState(() {
      users = transformed;
    });
  }
}

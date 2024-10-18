import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:restful_api/model/user.dart';
import 'package:restful_api/services/user_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          return ListTile(
            title: Text(user.fullName, style: GoogleFonts.lato()),
            subtitle: Text(user.location.country),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(user.picture.thumbnail),
            ),
          );
        },
      ),
    );
  }

  Future<void> fetchUsers() async {
    final response = await UserApi.fetchUser();
    setState(() {
      users = response;
    });
  }
}

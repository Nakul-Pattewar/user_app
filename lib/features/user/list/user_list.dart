import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_app/features/user/list/user_tile.dart';

import '../../../common/constants/strings.dart';
import '../user.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          child: const Text(
            listPageTitle,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.85,
            margin: EdgeInsets.all(5),
            child: FutureBuilder<List<User>>(
              future: loadUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(usersListErrorMessage));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text(noUsersTextMessage));
                }
                List<User> users = snapshot.data!;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return UserTile(
                      userName: users[index].userName,
                      userEmail: users[index].userEmail,
                      userGender: users[index].userGender,
                      userStatus: users[index].userStatus,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<User>> loadUsers() async {
    String jsonString = await rootBundle.loadString(usersListFilePath);

    List<dynamic> jsonList = json.decode(jsonString);

    List<User> users = jsonList.map((json) => User.fromJson(json)).toList();
    return users;
  }
}

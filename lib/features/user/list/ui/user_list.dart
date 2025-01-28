import 'package:flutter/material.dart';
import 'package:user_app/features/user/list/network/user_api.dart';
import 'package:user_app/features/user/list/ui/user_tile.dart';

import '../../../../common/constants/strings.dart';
import '../network/user_response.dart';

class UserList extends StatelessWidget {
  UserList({super.key});

  final UserApi userApi = UserApi();

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
            child: FutureBuilder<List<UserResponse>>(
              future: userApi.getUsersList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  String errorMessage = snapshot.error.toString();
                  return Center(
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(noUsersTextMessage),
                  );
                } else {
                  List<UserResponse> users = snapshot.data!;
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
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

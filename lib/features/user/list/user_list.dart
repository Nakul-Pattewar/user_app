import 'package:flutter/material.dart';
import 'package:user_app/features/user/list/user_tile.dart';

import '../../../common/constants/strings.dart';

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
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.85,
            margin: EdgeInsets.all(5),
            child: ListView(
              children: [
                UserTile(
                  userName: 'Nakul Pattewar',
                  userGender: 'male',
                  userEmail: 'nakulpattewar@gmail.com',
                  userStatus: 'active',
                ),
                UserTile(
                  userName: 'Abc Def',
                  userGender: 'female',
                  userEmail: 'abc@yahoo.com',
                  userStatus: 'inactive',
                ),
                UserTile(
                  userName: 'Aditya RaoSaheb Dube Kylas',
                  userGender: 'male',
                  userEmail: 'rao@gmail.com',
                  userStatus: 'inactive',
                ),
                UserTile(
                  userName: 'Pqr Mno',
                  userGender: 'female',
                  userEmail: 'xyzjcbjhsvbshvbshvbjhbjbbf@gmail.com',
                  userStatus: 'active',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

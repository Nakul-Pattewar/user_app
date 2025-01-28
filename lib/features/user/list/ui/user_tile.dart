import 'package:flutter/material.dart';
import 'package:user_app/common/widgets/popup_options_button.dart';
import 'package:user_app/common/widgets/user_status_dot.dart';

class UserTile extends StatelessWidget {
  const UserTile(
      {super.key,
        required this.userGender,
        required this.userName,
        required this.userEmail,
        required this.userStatus});
  final String userName;
  final String userGender;
  final String userEmail;
  final String userStatus;

  String getUserNameInitials(String name) {
    List<String> nameParts = name.trim().split(' ');
    String initials = '';

    for (int i = 0; i < nameParts.length && i < 2; i++) {
      if (nameParts[i].isNotEmpty) {
        initials += nameParts[i][0].toUpperCase();
      }
    }

    return initials;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(2, 4, 2, 4),
        margin: EdgeInsets.fromLTRB(2, 4, 2, 4),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(right: 5),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.teal[100],
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    getUserNameInitials(userName),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 230),
                          child: Text(
                            userName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 230),
                          child: Text(
                            userEmail,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        UserStatusDot(
                          userStatus: userStatus,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                child: Icon(
                    size: 30,
                    userGender == "male" ? Icons.male : Icons.female,
                    color: userGender == "male"
                        ? Colors.blueAccent
                        : Colors.pinkAccent),
              ),),
            Expanded(
              flex: 2,
              child:
              PopupOptionsButton(options: {'Edit': () {}, 'Delete': () {}}),
            )
          ],
        ));
  }
}
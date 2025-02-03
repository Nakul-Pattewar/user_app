import 'package:flutter/material.dart';
import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/common/utils/show_custom_dialog.dart';
import 'package:user_app/common/widgets/popup_options_button.dart';
import 'package:user_app/common/widgets/user_status_widget.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

import '../../../../common/constants/enums.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final UserResponse user;

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
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.teal[100],
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                getUserNameInitials(user.userName),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 230),
                      child: Text(
                        user.userName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 230),
                      child: Text(
                        user.userEmail,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  UserStatusWidget(
                    userStatus: user.userStatus,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
              child: Icon(
                  size: 30,
                  user.userGender == Gender.male.name
                      ? Icons.male
                      : Icons.female,
                  color: user.userGender == Gender.male.name
                      ? Colors.blueAccent
                      : Colors.pinkAccent),
            ),
          ),
          Expanded(
            flex: 2,
            child: PopupOptionsButton(
              options: {
                PopupOptions.edit.name: () {
                  showCustomDialog(
                      action: DialogAction.edit, context: context, user: user);
                },
                PopupOptions.delete.name: () {
                  showCustomDialog(
                      action: DialogAction.delete,
                      context: context,
                      user: user);
                },
              },
            ),
          ),
        ],
      ),
    );
  }
}

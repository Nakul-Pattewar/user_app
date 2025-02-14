import 'package:flutter/material.dart';
import 'package:user_app/common/utils/show_custom_dialog.dart';
import 'package:user_app/common/widgets/popup_options_button.dart';
import 'package:user_app/common/widgets/user_status_widget.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

import '../../../../common/constants/enums.dart';
import '../../../../common/utils/utils.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.user,
  });

  final UserResponse user;

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
                  user.userGender == Gender.male ? Icons.male : Icons.female,
                  color: user.userGender == Gender.male
                      ? Colors.blueAccent
                      : Colors.pinkAccent),
            ),
          ),
          Expanded(
            flex: 2,
            child: PopupOptionsButton(
              options: {
                DialogAction.edit: () {
                  showCustomDialog(
                    action: DialogAction.edit,
                    context: context,
                    user: user,
                  );
                },
                DialogAction.delete: () {
                  showCustomDialog(
                    action: DialogAction.delete,
                    context: context,
                    user: user,
                  );
                },
              },
            ),
          ),
        ],
      ),
    );
  }
}

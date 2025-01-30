import 'package:flutter/material.dart';

import '../constants/enums.dart';

class UserStatusWidget extends StatelessWidget {
  final String userStatus;

  const UserStatusWidget({super.key, required this.userStatus});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: userStatus == Status.active.name ? Colors.green[600] : Colors.red[600],
            shape: BoxShape.circle,
          ),
          constraints: BoxConstraints(
            minWidth: 7,
            minHeight: 7,
          ),
          margin: EdgeInsets.fromLTRB(1, 5, 5, 5),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 230),
          child: Text(
            userStatus,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class UserStatusDot extends StatelessWidget {
  final String userStatus;

  const UserStatusDot({super.key, required this.userStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: userStatus == 'active' ? Colors.green[600] : Colors.red[600],
        shape: BoxShape.circle,
      ),
      constraints: BoxConstraints(
        minWidth: 7,
        minHeight: 7,
      ),
      margin: EdgeInsets.all(5),
    );
  }
}

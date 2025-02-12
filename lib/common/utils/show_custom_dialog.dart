import 'package:flutter/material.dart';

import '../../features/user/add/ui/add_user_dialog.dart';
import '../../features/user/edit/ui/edit_user_dialog.dart';
import '../../features/user/list/network/user_response.dart';
import '../constants/enums.dart';

void showCustomDialog({
  UserResponse? user,
  required DialogAction action,
  required BuildContext context,
}) {
  switch (action) {
    case DialogAction.edit:
      if (user != null) {
        showDialog(
          context: context,
          builder: (context) => EditUserDialog(user: user),
        );
      } else {
        throw ArgumentError("User is required for editing.");
      }
      break;
    case DialogAction.delete:
      showDialog(
        context: context,
        builder: (context) => AlertDialog(),
      );
      break;
    case DialogAction.add:
      showDialog(
        context: context,
        builder: (context) => AddUserDialog(),
      );
      break;
    default:
      break;
  }
}

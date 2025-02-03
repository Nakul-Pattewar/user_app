import 'package:flutter/material.dart';
import 'package:user_app/common/constants/enums.dart';

import '../../features/user/edit/ui/edit_user_dialog.dart';
import '../../features/user/list/network/user_response.dart';

void showCustomDialog(
    {required DialogAction action,
    required BuildContext context,
    required UserResponse user}) {
  switch (action) {
    case DialogAction.edit:
      showDialog(
        context: context,
        builder: (context) => EditUserDialog(
          user: user,
        ),
      );
      break;
    case DialogAction.delete:
      showDialog(
        context: context,
        builder: (context) => AlertDialog(),
      );
      break;
    default:
      break;
  }
}

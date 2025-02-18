import 'package:flutter/material.dart';
import 'package:user_app/common/constants/strings.dart';

import '../../../../common/constants/enums.dart';
import '../../../../common/utils/show_custom_dialog.dart';

class AddUserButton extends StatelessWidget {
  const AddUserButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () {
          showCustomDialog(
            action: DialogAction.add,
            context: context,
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        child: const Text(
          addUserButtonTitle,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

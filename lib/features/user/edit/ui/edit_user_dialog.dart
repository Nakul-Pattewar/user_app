import 'package:flutter/material.dart';
import 'package:user_app/features/user/list/network/user_response.dart';
import '../../../../common/constants/enums.dart';
import '../../../../common/constants/strings.dart';

class EditUserDialog extends StatefulWidget {
  final UserResponse user;

  const EditUserDialog({
    super.key,
    required this.user,
  });

  @override
  EditUserDialogState createState() => EditUserDialogState();
}

class EditUserDialogState extends State<EditUserDialog> {
  late String gender = widget.user.userGender;
  late String status = widget.user.userStatus;
  late TextEditingController nameController =
      TextEditingController(text: widget.user.userName);
  late TextEditingController emailController =
      TextEditingController(text: widget.user.userEmail);

  Widget _editUserDialogTextField(
      {required TextEditingController controller,
      required String title,
      required TextInputType keyboardType}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
      keyboardType: keyboardType,
    );
  }

  Widget _radioListWidget<T extends Enum>(
      {required String label,
      required List<T> values,
      required String groupValue}) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ),
      Row(
        children: values.map((T g) {
          return Expanded(
            child: RadioListTile<String>(
              title: Text(
                g.name,
                style: TextStyle(fontSize: 16),
              ),
              contentPadding: EdgeInsets.zero,
              value: g.name,
              groupValue: groupValue,
              onChanged: (String? value) {
                setState(() {
                  if (label == editUserDialogStatusLabel) {
                    status = value!;
                  } else {
                    gender = value!;
                  }
                });
              },
            ),
          );
        }).toList(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(editUserDialogTitle),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _editUserDialogTextField(
                controller: nameController,
                title: editUserDialogNameTextFieldTitle,
                keyboardType: TextInputType.name),
            SizedBox(height: 10),
            _editUserDialogTextField(
                controller: emailController,
                title: editUserDialogEmailTextFieldTitle,
                keyboardType: TextInputType.emailAddress),
            SizedBox(height: 15),
            _radioListWidget(
                label: editUserDialogGenderLabel,
                values: Gender.values,
                groupValue: gender),
            SizedBox(height: 10),
            _radioListWidget(
                label: editUserDialogStatusLabel,
                values: Status.values,
                groupValue: status)
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(editUserDialogCancelButtonText),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(editUserDialogSaveAndCloseButtonText),
        ),
      ],
    );
  }
}

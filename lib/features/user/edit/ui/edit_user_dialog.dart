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
  late Gender gender = widget.user.userGender;
  late Status status = widget.user.userStatus;
  late TextEditingController nameController =
      TextEditingController(text: widget.user.userName);
  late TextEditingController emailController =
      TextEditingController(text: widget.user.userEmail);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        editUserDialogTitle,
      ),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EditUserDialogTextField(
              controller: nameController,
              title: editUserDialogNameTextFieldTitle,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 10),
            _EditUserDialogTextField(
              controller: emailController,
              title: editUserDialogEmailTextFieldTitle,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15),
            _RadioListWidget(
              label: editUserDialogGenderLabel,
              values: [Gender.male, Gender.female],
              groupValue: gender,
              onChanged: (Gender? value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            SizedBox(height: 10),
            _RadioListWidget(
              label: editUserDialogStatusLabel,
              values: [Status.active, Status.inactive],
              groupValue: status,
              onChanged: (Status? value) {
                setState(() {
                  status = value!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            editUserDialogCancelButtonText,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            editUserDialogSaveAndCloseButtonText,
          ),
        ),
      ],
    );
  }
}

class _EditUserDialogTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType keyboardType;

  const _EditUserDialogTextField({
    required this.controller,
    required this.title,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
      keyboardType: keyboardType,
    );
  }
}

class _RadioListWidget<T extends Enum> extends StatelessWidget {
  final String label;
  final List<T> values;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const _RadioListWidget({
    super.key,
    required this.values,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
      Row(
        children: values.map((T g) {
          return Expanded(
            child: RadioListTile<T>(
              title: Text(
                g.name,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              value: g,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          );
        }).toList(),
      ),
    ]);
  }
}

import 'package:flutter/material.dart';
import '../../../../common/constants/enums.dart';
import '../../../../common/constants/strings.dart';

class EditUserDialog extends StatefulWidget {
  final String name;
  final String email;
  final String selectedGender;
  final String selectedStatus;

  const EditUserDialog({
    super.key,
    required this.name,
    required this.email,
    required this.selectedGender,
    required this.selectedStatus,
  });

  @override
  EditUserDialogState createState() => EditUserDialogState();
}

class EditUserDialogState extends State<EditUserDialog> {
  late String gender = widget.selectedGender;
  late String status = widget.selectedStatus;
  late TextEditingController nameController =
      TextEditingController(text: widget.name);
  late TextEditingController emailController =
      TextEditingController(text: widget.email);

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
            TextField(
              controller: nameController,
              decoration:
                  InputDecoration(labelText: editUserDialogNameTextFieldTitle),
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration:
                  InputDecoration(labelText: editUserDialogEmailTextFieldTitle),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                editUserDialogGenderLabel,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Row(
              children: Gender.values.map((Gender g) {
                return Expanded(
                  child: RadioListTile<String>(
                    title: Text(
                      g.name,
                      style: TextStyle(fontSize: 16),
                    ),
                    contentPadding: EdgeInsets.zero,
                    value: g.name,
                    groupValue: gender,
                    onChanged: (String? value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                editUserDialogStatusLabel,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Row(
              children: Status.values.map((Status s) {
                return Expanded(
                  child: RadioListTile<String>(
                    title: Text(
                      s.name,
                      style: TextStyle(fontSize: 16),
                    ),
                    contentPadding: EdgeInsets.zero,
                    value: s.name,
                    groupValue: status,
                    onChanged: (String? value) {
                      setState(() {
                        status = value!;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
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

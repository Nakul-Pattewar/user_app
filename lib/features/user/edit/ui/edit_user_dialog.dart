import 'package:flutter/material.dart';
import 'package:user_app/features/user/list/network/user_response.dart';
import '../../../../common/constants/enums.dart';
import '../../../../common/constants/strings.dart';
import '../../../../common/utils/utils.dart';

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
  bool _isEmailValid = true;
  bool _isNameValid = true;

  void _OnEmailChanged(String value) {
    setState(() {
      _isEmailValid = validateEmail(value) == null;
    });
  }

  void _OnNameChanged(String value) {
    setState(() {
      _isNameValid = validateName(value) == null;
    });
  }

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
              onChanged: _OnNameChanged,
            ),
            SizedBox(height: 10),
            _EditUserDialogTextField(
              controller: emailController,
              title: editUserDialogEmailTextFieldTitle,
              keyboardType: TextInputType.emailAddress,
              onChanged: _OnEmailChanged,
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
          onPressed: _isEmailValid && _isNameValid
              ? () {
                  Navigator.of(context).pop();
                }
              : null,
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
  final void Function(String)? onChanged;

  const _EditUserDialogTextField({
    required this.controller,
    required this.title,
    required this.keyboardType,
    this.onChanged,
  });

  String? _GetTextFieldError(TextInputType keyboardType) {
    if (keyboardType == TextInputType.emailAddress) {
      return validateEmail(controller.text);
    } else if (keyboardType == TextInputType.name) {
      return validateName(controller.text);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        errorText: _GetTextFieldError(keyboardType),
      ),
      keyboardType: keyboardType,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
        (context as Element).markNeedsBuild();
      },
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

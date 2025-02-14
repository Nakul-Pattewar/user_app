import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/user/add/bloc/add_user_cubit.dart';
import '../../features/user/edit/bloc/edit_user_cubit.dart';
import '../../features/user/list/network/user_response.dart';
import '../constants/enums.dart';
import '../constants/strings.dart';
import '../state/ui_state.dart';
import '../utils/utils.dart';

class UserDialog extends StatefulWidget {
  const UserDialog({
    super.key,
    required this.action,
    required this.state,
    this.user,
  });

  final DialogAction action;
  final UiState state;
  final UserResponse? user;

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  late UserResponse? user = widget.user;

  late Gender gender = user?.userGender ?? Gender.undefined;
  late Status status = user?.userStatus ?? Status.undefined;
  late String name = user?.userName ?? '';
  late String email = user?.userEmail ?? '';
  late TextEditingController nameController = TextEditingController(text: name);
  late TextEditingController emailController =
      TextEditingController(text: email);
  bool _isEmailValid = true;
  bool _isNameValid = true;

  void _onEmailChanged(String value) {
    user?.userEmail = value;
    setState(() {
      _isEmailValid = (validateEmail(value) == null);
    });
  }

  void _onNameChanged(String value) {
    user?.userName = value;
    setState(() {
      _isNameValid = validateName(value) == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        addUserDialogTitle,
      ),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AddUserDialogTextField(
              controller: nameController,
              title: userDialogNameTextFieldTitle,
              keyboardType: TextInputType.name,
              onChanged: _onNameChanged,
            ),
            SizedBox(height: 10),
            _AddUserDialogTextField(
              controller: emailController,
              title: userDialogEmailTextFieldTitle,
              keyboardType: TextInputType.emailAddress,
              onChanged: _onEmailChanged,
            ),
            SizedBox(height: 15),
            _RadioListWidget(
              label: userDialogGenderLabel,
              values: [Gender.male, Gender.female],
              groupValue: gender,
              onChanged: (Gender? value) {
                if (value != null) {
                  gender = value;
                }
                setState(
                  () {
                    gender = value!;
                  },
                );
              },
            ),
            SizedBox(height: 10),
            _RadioListWidget(
              label: userDialogStatusLabel,
              values: [Status.active, Status.inactive],
              groupValue: status,
              onChanged: (Status? value) {
                if (value != null) status = value;
                setState(
                  () {
                    status = value!;
                  },
                );
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
            userDialogCancelButtonText,
          ),
        ),
        ElevatedButton(
          onPressed: (widget.action == DialogAction.add)
              ? _isEmailValid &&
                      _isNameValid &&
                      user?.userStatus != Status.undefined &&
                      user?.userGender != Gender.undefined
                  ? () async {
                      name = nameController.text;
                      email = emailController.text;
                      gender = gender;
                      status = status;

                      await context.read<AddUserCubit>().addUser(
                            UserResponse(
                                userName: name,
                                userGender: gender,
                                userEmail: email,
                                userStatus: status,
                                userId: 0),
                          );
                    }
                  : null
              : _isEmailValid &&
                      _isNameValid &&
                      status != Status.undefined &&
                      gender != Gender.undefined
                  ? () async {
                      name = nameController.text;
                      email = emailController.text;
                      gender = gender;
                      status = status;

                      await context.read<EditUserCubit>().updateUser(
                            UserResponse(
                                userName: name,
                                userGender: gender,
                                userEmail: email,
                                userStatus: status,
                                userId: user?.userId ?? 0),
                          );
                    }
                  : null,
          child: (widget.state is Loading)
              ? CircularProgressIndicator()
              : Text(
                  userDialogSaveAndCloseButtonText,
                ),
        ),
      ],
    );
  }
}

class _AddUserDialogTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType keyboardType;
  final void Function(String) onChanged;

  const _AddUserDialogTextField({
    required this.controller,
    required this.title,
    required this.keyboardType,
    required this.onChanged,
  });

  String? _getTextFieldError(TextInputType keyboardType) {
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
        errorText: _getTextFieldError(keyboardType),
      ),
      keyboardType: keyboardType,
      onChanged: (value) {
        onChanged(value);
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

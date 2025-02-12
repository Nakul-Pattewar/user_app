import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/user/edit/bloc/edit_user_cubit.dart';
import 'package:user_app/features/user/list/network/user_response.dart';
import '../../../../common/constants/enums.dart';
import '../../../../common/constants/strings.dart';
import '../../../../common/state/ui_state.dart';
import '../../../../common/utils/utils.dart';
import '../../list/bloc/user_cubit.dart';

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
  late UserResponse user = widget.user;
  late TextEditingController nameController =
      TextEditingController(text: user.userName);
  late TextEditingController emailController =
      TextEditingController(text: user.userEmail);
  bool _isEmailValid = true;
  bool _isNameValid = true;

  void _onEmailChanged(String value) {
    user.userEmail = value;
    setState(() {
      _isEmailValid = (validateEmail(value) == null);
    });
  }

  void _onNameChanged(String value) {
    user.userName = value;
    setState(() {
      _isNameValid = validateName(value) == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditUserCubit(),
      child: BlocConsumer<EditUserCubit, UiState<bool>>(
        builder: (context, state) {
          if (state is Success) {
            return SizedBox.shrink();
          } else {
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
                      onChanged: _onNameChanged,
                    ),
                    SizedBox(height: 10),
                    _EditUserDialogTextField(
                      controller: emailController,
                      title: editUserDialogEmailTextFieldTitle,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: _onEmailChanged,
                    ),
                    SizedBox(height: 15),
                    _RadioListWidget(
                      label: editUserDialogGenderLabel,
                      values: [Gender.male, Gender.female],
                      groupValue: user.userGender,
                      onChanged: (Gender? value) {
                        if (value != null) {
                          user.userGender = value;
                        }
                        setState(
                          () {
                            user.userGender = value!;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    _RadioListWidget(
                      label: editUserDialogStatusLabel,
                      values: [Status.active, Status.inactive],
                      groupValue: user.userStatus,
                      onChanged: (Status? value) {
                        if (value != null) user.userStatus = value;
                        setState(
                          () {
                            user.userStatus = value!;
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
                    editUserDialogCancelButtonText,
                  ),
                ),
                ElevatedButton(
                  onPressed: _isEmailValid && _isNameValid
                      ? () async {
                          await context.read<EditUserCubit>().updateUser(user);
                        }
                      : null,
                  child: (state is Loading)
                      ? CircularProgressIndicator()
                      : Text(
                          editUserDialogSaveAndCloseButtonText,
                        ),
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is Success) {
            Navigator.of(context).pop();
            context.read<UserCubit>().fetchUsers();
          }
          if (state is Error || state is Success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(
                        (state is Error)
                            ? Icons.error_outline
                            : Icons.check_circle_outline,
                        color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        (state is Error)
                            ? unexpectedErrorMessage
                            : userUpdateSuccessMessage,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                backgroundColor: (state is Error)
                    ? Colors.red.shade600
                    : Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                  left: 16,
                  right: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
      ),
    );
  }
}

class _EditUserDialogTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType keyboardType;
  final void Function(String) onChanged;

  const _EditUserDialogTextField({
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

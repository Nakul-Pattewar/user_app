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
  late Gender gender = widget.user.userGender;
  late Status status = widget.user.userStatus;
  late TextEditingController nameController =
      TextEditingController(text: widget.user.userName);
  late TextEditingController emailController =
      TextEditingController(text: widget.user.userEmail);
  bool _isEmailValid = true;
  bool _isNameValid = true;

  void _onEmailChanged(String value) {
    widget.user.userEmail = value;
    setState(() {
      _isEmailValid = (validateEmail(value) == null);
    });
  }

  void _onNameChanged(String value) {
    widget.user.userName = value;
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
          if (state is Default || state is Loading || state is Error) {
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
                      groupValue: gender,
                      onChanged: (Gender? value) {
                        if (value != null) {
                          widget.user.userGender = value;
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
                      label: editUserDialogStatusLabel,
                      values: [Status.active, Status.inactive],
                      groupValue: status,
                      onChanged: (Status? value) {
                        if (value != null) widget.user.userStatus = value;
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
                    editUserDialogCancelButtonText,
                  ),
                ),
                ElevatedButton(
                  onPressed: _isEmailValid && _isNameValid
                      ? () async {
                          await context
                              .read<EditUserCubit>()
                              .updateUser(widget.user);
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
          } else {
            return SizedBox.shrink();
          }
        },
        listener: (context, state) {
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        unexpectedErrorMessage,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.red.shade600,
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
          if (state is Success) {
            Navigator.of(context).pop();
            context.read<UserCubit>().fetchUsers();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        userUpdateSuccessMessage,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: Duration(seconds: 2),
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

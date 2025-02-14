import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/common/widgets/user_dialog.dart';
import 'package:user_app/features/user/edit/bloc/edit_user_cubit.dart';
import 'package:user_app/features/user/list/network/user_api.dart';
import 'package:user_app/features/user/list/network/user_response.dart';
import '../../../../common/constants/enums.dart';
import '../../../../common/constants/strings.dart';
import '../../../../common/state/ui_state.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditUserCubit(UserApi()),
      child: BlocConsumer<EditUserCubit, UiState<bool>>(
        builder: (context, state) {
          if (state is Success) {
            return SizedBox.shrink();
          } else {
            return UserDialog(
              action: DialogAction.edit,
              state: state,
              user: user,
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
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

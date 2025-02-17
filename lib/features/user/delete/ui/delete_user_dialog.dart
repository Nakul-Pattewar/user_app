import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/user/delete/bloc/delete_user_cubit.dart';
import 'package:user_app/features/user/list/network/user_api.dart';
import 'package:user_app/features/user/list/network/user_response.dart';
import '../../../../common/constants/strings.dart';
import '../../../../common/state/ui_state.dart';
import '../../list/bloc/user_cubit.dart';

class DeleteUserDialog extends StatefulWidget {
  final UserResponse user;

  const DeleteUserDialog({
    super.key,
    required this.user,
  });

  @override
  DeleteUserDialogState createState() => DeleteUserDialogState();
}

class DeleteUserDialogState extends State<DeleteUserDialog> {
  late String userName = widget.user.userName;
  late int userId = widget.user.userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteUserCubit(UserApi()),
      child: BlocConsumer<DeleteUserCubit, UiState<bool>>(
        builder: (context, state) {
          if (state is Success) {
            return SizedBox.shrink();
          } else {
            return AlertDialog(
              title: Text(
                deleteUserDialogTitle,
              ),
              backgroundColor: Colors.white,
              content: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$confirmDeleteText$userName ?",
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
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade500,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    await context.read<DeleteUserCubit>().deleteUser(userId);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.white,
                  ),
                  label: (state is Loading)
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          deleteButtonText,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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
                            : userDeleteSuccessMessage,
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

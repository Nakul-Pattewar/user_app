import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/common/widgets/user_dialog.dart';
import 'package:user_app/features/user/list/network/user_api.dart';
import '../../../../common/constants/enums.dart';
import '../../../../common/constants/strings.dart';
import '../../../../common/state/ui_state.dart';
import '../../list/bloc/user_cubit.dart';
import '../bloc/add_user_cubit.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({
    super.key,
  });

  @override
  AddUserDialogState createState() => AddUserDialogState();
}

class AddUserDialogState extends State<AddUserDialog> {
  late Gender gender = Gender.undefined;
  late Status status = Status.undefined;
  late String name = '';
  late String email = '';
  late TextEditingController nameController = TextEditingController(text: '');
  late TextEditingController emailController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddUserCubit(UserApi()),
      child: BlocConsumer<AddUserCubit, UiState<bool>>(
        builder: (context, state) {
          if (state is Success) {
            return SizedBox.shrink();
          } else {
            return UserDialog(
              action: DialogAction.add,
              state: state,
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
                            : userAddedSuccessMessage,
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

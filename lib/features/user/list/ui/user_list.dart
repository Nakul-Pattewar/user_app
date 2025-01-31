import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/user/list/bloc/user_cubit.dart';
import 'package:user_app/features/user/list/network/user_api.dart';
import 'package:user_app/features/user/list/ui/user_tile.dart';

import '../../../../common/constants/strings.dart';
import '../../../../common/state/ui_state.dart';
import '../network/user_response.dart';

class UserList extends StatelessWidget {
  UserList({super.key});

  final UserApi userApi = UserApi();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          child: const Text(
            listPageTitle,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.85,
            margin: EdgeInsets.all(5),
            child: BlocBuilder<UserCubit, UiState<List<UserResponse>>>(
              builder: (context, state) {
                if (state is Loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else if (state is Success) {
                  List<UserResponse> users = (state as Success).getData;
                  if (users.isEmpty) {
                    return Center(
                      child: Text(noUsersTextMessage),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return UserTile(
                          userName: users[index].userName,
                          userEmail: users[index].userEmail,
                          userGender: users[index].userGender,
                          userStatus: users[index].userStatus,
                        );
                      },
                    );
                  }
                } else if (state is Error) {
                  String errorMessage = (state as Error).getError.toString();
                  return Center(
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                } else {
                  return Center(
                    child: Text(unexpectedErrorMessage),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

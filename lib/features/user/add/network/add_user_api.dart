import 'dart:convert';

import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/common/network/base_api.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

class AddUserApi extends BaseApi {
  AddUserApi({super.client});

  Future<bool> addUser(UserResponse user) async {
    final Uri uri = getUri(addUserEndpoint);

    final body = jsonEncode({
      "name": user.userName,
      "email": user.userEmail,
      "gender": user.userGender.name,
      "status": user.userStatus.name
    });

    final request = client.post(
      uri,
      headers: super.getHeaders(),
      body: body,
    );

    final response = await send(request);
    if (response.statusCode < 300) {
      return true;
    } else {
      return false;
    }
  }
}

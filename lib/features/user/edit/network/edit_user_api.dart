import 'dart:convert';

import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/common/network/base_api.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

class EditUserApi extends BaseApi {
  EditUserApi({super.client});

  Future<bool> updateUser(UserResponse user) async {
    final int userId = user.userId;
    final Uri uri = getUri('$editUserEndpoint/$userId');

    final body = jsonEncode({
      "name": user.userName,
      "email": user.userEmail,
      "gender": user.userGender.name,
      "status": user.userStatus.name
    });

    final request = client.put(
      uri,
      headers: super.getHeaders(),
      body: body,
    );

    final response = await send(request);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

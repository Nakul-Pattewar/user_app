import 'dart:convert';

import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/common/network/base_api.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

class UserApi extends BaseApi {
  UserApi({super.client});

  Future<List<UserResponse>> getUsersList() async {
    final Uri uri = getUri(userApiEndpoint);

    final request = client.get(
      uri,
      headers: super.getHeaders(),
    );

    final response = await send(request);
    List<dynamic> jsonList = json.decode(response.body);

    List<UserResponse> users =
        jsonList.map((json) => UserResponse.fromJson(json)).toList();
    return users;
  }

  Future<bool> updateUser(UserResponse user) async {
    final int userId = user.userId;
    final Uri uri = getUri('$userApiEndpoint/$userId');

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

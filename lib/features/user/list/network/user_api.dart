import 'dart:convert';

import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/common/network/base_api.dart';
import 'package:user_app/features/user/list/network/user_response.dart';
import 'package:http/http.dart' as http_client;

class UserApi extends BaseApi {
  Future<List<UserResponse>> getUsersList() async {

    final Uri uri = getUri(usersListEndpoint);

    final request = http_client.get(uri);

    final response = await send(request);
    List<dynamic> jsonList = json.decode(response.body);

    List<UserResponse> users =
        jsonList.map((json) => UserResponse.fromJson(json)).toList();
    return users;
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/common/network/base_api.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

class UserApi extends BaseApi {
  Future<List<UserResponse>> getUsersList(http.Client client) async {
    final Uri uri = getUri(usersListEndpoint);

    final request = client.get(uri);

    final response = await send(request);
    List<dynamic> jsonList = json.decode(response.body);

    List<UserResponse> users =
        jsonList.map((json) => UserResponse.fromJson(json)).toList();
    return users;
  }
}

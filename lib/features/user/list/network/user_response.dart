import 'package:user_app/common/extensions/string_extensions.dart';

import '../../../../common/constants/enums.dart';

class UserResponse {
  final int userId;
  late String userName;
  late Gender userGender;
  late String userEmail;
  late Status userStatus;

  UserResponse({
    required this.userName,
    required this.userGender,
    required this.userEmail,
    required this.userStatus,
    required this.userId,
  });

  UserResponse.fromJson(Map<String, dynamic> json)
      : userId = json['id'] as int,
        userName = json['name'] as String,
        userEmail = json['email'] as String,
        userGender = (json['gender'] as String).toGender(),
        userStatus = (json['status'] as String).toStatus();

  Map<String, dynamic> toJson() => {
        'id': userId,
        'name': userName,
        'email': userEmail,
        'gender': userGender,
        'status': userStatus,
      };
}

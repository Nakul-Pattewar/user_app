import 'package:user_app/common/extensions/string_extensions.dart';

import '../../../../common/constants/enums.dart';

class UserResponse {
  final int userId;
  late final String userName;
  late final Gender userGender;
  late final String userEmail;
  late final Status userStatus;

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

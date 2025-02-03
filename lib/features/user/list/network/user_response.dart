import 'package:user_app/common/extensions/string_extensions.dart';

import '../../../../common/constants/enums.dart';

class UserResponse {
  final int userId;
  final String userName;
  final Gender userGender;
  final String userEmail;
  final Status userStatus;

  UserResponse(this.userName, this.userGender, this.userEmail, this.userStatus,
      this.userId);

  UserResponse.fromJson(Map<String, dynamic> json)
      : userId = json['id'] as int,
        userName = json['name'] as String,
        userEmail = json['email'] as String,
        userGender = (json['gender'] as String).toLowerCase().toGender(),
        userStatus = (json['status'] as String).toLowerCase().toStatus();

  Map<String, dynamic> toJson() => {
        'id': userId,
        'name': userName,
        'email': userEmail,
        'gender': userGender,
        'status': userStatus,
      };
}

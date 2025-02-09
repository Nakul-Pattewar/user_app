class UserResponse {
  final int userId;
  final String userName;
  final String userGender;
  final String userEmail;
  final String userStatus;

  UserResponse(this.userName, this.userGender, this.userEmail, this.userStatus,
      this.userId);

  UserResponse.fromJson(Map<String, dynamic> json)
      : userId = json['id'] as int,
        userName = json['name'] as String,
        userEmail = json['email'] as String,
        userGender = json['gender'] as String,
        userStatus = json['status'] as String;

  Map<String, dynamic> toJson() => {
        'id': userId,
        'name': userName,
        'email': userEmail,
        'gender': userGender,
        'status': userStatus,
      };
}

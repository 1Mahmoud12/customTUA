class UserInfoResponseModel {
  final bool success;
  final String message;
  final UserDataModel data;

  UserInfoResponseModel({required this.success, required this.message, required this.data});

  factory UserInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return UserInfoResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: UserDataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class UserDataModel {
  final UserInfoModel userInfo;
  final List<SecondaryUserModel> secondaryUsers;

  UserDataModel({required this.userInfo, required this.secondaryUsers});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userInfo: UserInfoModel.fromJson(json['user_info']),
      secondaryUsers:
          (json['secondary-users'] as List<dynamic>).map((e) => SecondaryUserModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_info': userInfo.toJson(),
      'secondary-users': secondaryUsers.map((e) => e.toJson()).toList(),
    };
  }
}

class UserInfoModel {
  final int id;
  final String guid;
  final String email;
  final String? password;
  final String firstName;
  final String lastName;
  final int nationalityId;
  final int residencyId;
  final String countryCode;
  final String phone;
  final String gender;
  final String authKey;
  final String accessToken;
  final int createdAt;
  final int updatedAt;
  final int status;
  final String? otp;
  final int? otpSendAt;
  final int? phoneChangedAt;
  final int otpCounts;
  final String? avatar;

  UserInfoModel({
    required this.id,
    required this.guid,
    required this.email,
    this.password,
    required this.firstName,
    required this.lastName,
    required this.nationalityId,
    required this.residencyId,
    required this.countryCode,
    required this.phone,
    required this.gender,
    required this.authKey,
    required this.accessToken,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.otp,
    this.otpSendAt,
    this.phoneChangedAt,
    required this.otpCounts,
    this.avatar,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'] ?? 0,
      guid: json['guid'] ?? '',
      email: json['email'] ?? '',
      password: json['password'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      nationalityId: json['nationality_id'] ?? 0,
      residencyId: json['residency_id'] ?? 0,
      countryCode: json['country_code'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      authKey: json['auth_key'] ?? '',
      accessToken: json['access_token'] ?? '',
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
      status: json['status'] ?? 0,
      otp: json['otp'],
      otpSendAt: json['otp_send_at'],
      phoneChangedAt: json['phone_changed_at'],
      otpCounts: json['otp_counts'] ?? 0,
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guid': guid,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'nationality_id': nationalityId,
      'residency_id': residencyId,
      'country_code': countryCode,
      'phone': phone,
      'gender': gender,
      'auth_key': authKey,
      'access_token': accessToken,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'status': status,
      'otp': otp,
      'otp_send_at': otpSendAt,
      'phone_changed_at': phoneChangedAt,
      'otp_counts': otpCounts,
      'avatar': avatar,
    };
  }
}

class SecondaryUserModel {
  final int id;
  final String name;
  final String guid;

  SecondaryUserModel({required this.id, required this.name, required this.guid});

  factory SecondaryUserModel.fromJson(Map<String, dynamic> json) {
    return SecondaryUserModel(id: json['id'] ?? 0, name: json['name'] ?? '', guid: json['guid'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'guid': guid};
  }
}

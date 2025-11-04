class LoginModel {
  LoginModel({required this.success, required this.message, required this.data});

  final bool? success;
  final String? message;
  final Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(success: json['success'], message: json['message'], data: json['data'] == null ? null : Data.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() => {'success': success, 'message': message, 'data': data?.toJson()};
}

class Data {
  Data({required this.userInfo});

  final UserInfo? userInfo;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(userInfo: json['user_info'] == null ? null : UserInfo.fromJson(json['user_info']));
  }

  Map<String, dynamic> toJson() => {'user_info': userInfo?.toJson()};
}

class UserInfo {
  UserInfo({
    required this.id,
    required this.guid,
    required this.email,
    required this.password,
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
    required this.otp,
    required this.otpSendAt,
    required this.phoneChangedAt,
    required this.otpCounts,
    required this.photoPath,
  });

  final int? id;
  final String? guid;
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final int? nationalityId;
  final int? residencyId;
  final String? countryCode;
  final String? phone;
  final String? gender;
  final String? authKey;
  final String? accessToken;
  final String? photoPath;
  final num? createdAt;
  final num? updatedAt;
  final num? status;
  final dynamic otp;
  final dynamic otpSendAt;
  final dynamic phoneChangedAt;
  final num? otpCounts;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      guid: json['guid'],
      photoPath: json['photo_path'],
      email: json['email'],
      password: json['password'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      nationalityId: json['nationality_id'],
      residencyId: json['residency_id'],
      countryCode: json['country_code'],
      phone: json['phone'],
      gender: json['gender'],
      authKey: json['auth_key'],
      accessToken: json['access_token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
      otp: json['otp'],
      otpSendAt: json['otp_send_at'],
      phoneChangedAt: json['phone_changed_at'],
      otpCounts: json['otp_counts'],
    );
  }

  Map<String, dynamic> toJson() => {
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
    'photo_path': photoPath,
  };
}

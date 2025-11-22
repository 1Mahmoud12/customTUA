import 'basic_page_model.dart';

class BasicPageResponseModel {
  final bool success;
  final String? message;
  final BasicPageModel data;

  BasicPageResponseModel({
    required this.success,
    this.message,
    required this.data,
  });

  factory BasicPageResponseModel.fromJson(Map<String, dynamic> json) {
    return BasicPageResponseModel(
      success: json['success'] ?? false,
      message: json['message'],
      data: BasicPageModel.fromJson(json['data'] ?? {}),
    );
  }
}

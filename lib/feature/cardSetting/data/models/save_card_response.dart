class SaveCardResponse {
  final bool success;
  final String message;
  final SaveCardData data;

  SaveCardResponse({required this.success, required this.message, required this.data});

  factory SaveCardResponse.fromJson(Map<String, dynamic> json) {
    return SaveCardResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: SaveCardData.fromJson(json['data']),
    );
  }
}

class SaveCardData {
  final String checkoutId;
  final String integrity;

  SaveCardData({required this.checkoutId, required this.integrity});

  factory SaveCardData.fromJson(Map<String, dynamic> json) {
    return SaveCardData(checkoutId: json['checkoutId'] ?? '', integrity: json['integrity'] ?? '');
  }
}

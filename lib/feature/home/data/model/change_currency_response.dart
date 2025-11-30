/// Main response model
class ChangeCurrencyResponse {
  final bool success;
  final String message;
  final CurrencyData data;

  const ChangeCurrencyResponse({required this.success, required this.message, required this.data});

  factory ChangeCurrencyResponse.fromJson(Map<String, dynamic> json) {
    return ChangeCurrencyResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CurrencyData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

/// Inner data model
class CurrencyData {
  final String currency;

  const CurrencyData({required this.currency});

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(currency: json['currency'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'currency': currency};
  }
}

class HyperPayCheckoutResponse {
  final bool success;
  final String message;
  final HyperPayData data;

  HyperPayCheckoutResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HyperPayCheckoutResponse.fromJson(Map<String, dynamic> json) =>
      HyperPayCheckoutResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        data: HyperPayData.fromJson(json['data'] ?? {}),
      );
}

class HyperPayData {
  final int totalDonationScheme;
  final String subTotal;
  final String total;
  final HyperPayCheckout checkout;
  final List<dynamic> cards;

  HyperPayData({
    required this.totalDonationScheme,
    required this.subTotal,
    required this.total,
    required this.checkout,
    required this.cards,
  });

  factory HyperPayData.fromJson(Map<String, dynamic> json) => HyperPayData(
    totalDonationScheme: json['total_donation_scheme'] ?? 0,
    subTotal: json['sub_total'] ?? '',
    total: json['total'] ?? '',
    checkout: HyperPayCheckout.fromJson(json['checkout'] ?? {}),
    cards: json['cards'] ?? [],
  );
}

class HyperPayCheckout {
  final bool status;
  final HyperPayCheckoutInner data;

  HyperPayCheckout({
    required this.status,
    required this.data,
  });

  factory HyperPayCheckout.fromJson(Map<String, dynamic> json) =>
      HyperPayCheckout(
        status: json['status'] ?? false,
        data: HyperPayCheckoutInner.fromJson(json['data'] ?? {}),
      );
}

  class HyperPayCheckoutInner {
  final Map<String, dynamic> result;
  final String buildNumber;
  final String timestamp;
  final String ndc;
  final String id;
  final String integrity;

  HyperPayCheckoutInner({
    required this.result,
    required this.buildNumber,
    required this.timestamp,
    required this.ndc,
    required this.id,
    required this.integrity,
  });

  factory HyperPayCheckoutInner.fromJson(Map<String, dynamic> json) =>
      HyperPayCheckoutInner(
        result: json['result'] ?? {},
        buildNumber: json['buildNumber'] ?? '',
        timestamp: json['timestamp'] ?? '',
        ndc: json['ndc'] ?? '',
        id: json['id'] ?? '',
        integrity: json['integrity'] ?? '',
      );
}

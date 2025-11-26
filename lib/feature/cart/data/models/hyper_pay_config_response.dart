class HyperPayConfigResponse {
  final bool success;
  final String message;
  final HyperPayConfigData data;

  HyperPayConfigResponse({required this.success, required this.message, required this.data});

  factory HyperPayConfigResponse.fromJson(Map<String, dynamic> json) => HyperPayConfigResponse(
    success: json['success'] ?? false,
    message: json['message'] ?? '',
    data: HyperPayConfigData.fromJson(json['data'] ?? {}),
  );
}

class HyperPayConfigData {
  final String hyperPayPaymentUrl;
  final String hyperPayAuthorizationToken;
  final String hyperPayEntityIdJod;
  final String hyperPayRecurringEntityIdJod;
  final String hyperPayEntityIdUsd;
  final String hyperPayRecurringEntityIdUsd;
  final String dataBrands;
  final String shopperResultUrl;

  HyperPayConfigData({
    required this.hyperPayPaymentUrl,
    required this.hyperPayAuthorizationToken,
    required this.hyperPayEntityIdJod,
    required this.hyperPayRecurringEntityIdJod,
    required this.hyperPayEntityIdUsd,
    required this.hyperPayRecurringEntityIdUsd,
    required this.dataBrands,
    required this.shopperResultUrl,
  });

  factory HyperPayConfigData.fromJson(Map<String, dynamic> json) => HyperPayConfigData(
    hyperPayPaymentUrl: json['HYPER_PAY_PAYMENT_URL'] ?? '',
    hyperPayAuthorizationToken: json['HYPER_PAY_AUTHORIZATION_TOKEN'] ?? '',
    hyperPayEntityIdJod: json['HYPER_PAY_ENTITY_ID_JOD'] ?? '',
    hyperPayRecurringEntityIdJod: json['HYPER_PAY_RECURRING_ENTITY_ID_JOD'] ?? '',
    hyperPayEntityIdUsd: json['HYPER_PAY_ENTITY_ID_USD'] ?? '',
    hyperPayRecurringEntityIdUsd: json['HYPER_PAY_RECURRING_ENTITY_ID_USD'] ?? '',
    shopperResultUrl: json['Shopper_Result_Url'] ?? 'https://www.google.com',
    dataBrands: json['data-brands'] ?? '',
  );
}

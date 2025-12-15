class GetCardsResponse {
  final bool success;
  final String message;
  final CardsData data;

  GetCardsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetCardsResponse.fromJson(Map<String, dynamic> json) {
    return GetCardsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CardsData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CardsData {
  final List<CardInfo> cards;

  CardsData({required this.cards});

  factory CardsData.fromJson(Map<String, dynamic> json) {
    var list = json['cards'] as List<dynamic>? ?? [];
    List<CardInfo> cardsList = list.map((e) => CardInfo.fromJson(e)).toList();
    return CardsData(cards: cardsList);
  }

  Map<String, dynamic> toJson() {
    return {
      'cards': cards.map((e) => e.toJson()).toList(),
    };
  }
}

class CardInfo {
  final int id;
  final int parentId;
  final String token;
  final String bin;
  final String lastFourDigits;
  final String holder;
  final int expiryMonth;
  final int expiryYear;
  final int createdAt;
  final int updatedAt;
  final String type;
  final String recurringPaymentAgreement;

  CardInfo({
    required this.id,
    required this.parentId,
    required this.token,
    required this.bin,
    required this.lastFourDigits,
    required this.holder,
    required this.expiryMonth,
    required this.expiryYear,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.recurringPaymentAgreement,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) {
    return CardInfo(
      id: json['id'] ?? 0,
      parentId: json['parent_id'] ?? 0,
      token: json['token'] ?? '',
      bin: json['bin'] ?? '',
      lastFourDigits: json['last_four_digits'] ?? '',
      holder: json['holder'] ?? '',
      expiryMonth: json['expiry_month'] ?? 0,
      expiryYear: json['expiry_year'] ?? 0,
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
      type: json['type'] ?? '',
      recurringPaymentAgreement: json['recurring_payment_agreement'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'token': token,
      'bin': bin,
      'last_four_digits': lastFourDigits,
      'holder': holder,
      'expiry_month': expiryMonth,
      'expiry_year': expiryYear,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'type': type,
      'recurring_payment_agreement': recurringPaymentAgreement,
    };
  }
}
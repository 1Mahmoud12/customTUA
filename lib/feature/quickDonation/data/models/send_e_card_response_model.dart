import '../../../cart/data/models/hyper_pay_checkout_response.dart';

class SendECardResponseModel {
  final bool success;
  final String message;
  final SendECardData data;

  SendECardResponseModel({required this.success, required this.message, required this.data});

  factory SendECardResponseModel.fromJson(Map<String, dynamic> json) {
    return SendECardResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: SendECardData.fromJson(json['data'] ?? {}),
    );
  }
}

class SendECardData {
  final ECardModel model;
  final CheckoutModel checkout;

  SendECardData({required this.model, required this.checkout});

  factory SendECardData.fromJson(Map<String, dynamic> json) {
    return SendECardData(
      model: ECardModel.fromJson(json['model'] ?? {}),
      checkout: CheckoutModel.fromJson(json['checkout'] ?? {}),
    );
  }
}

class ECardModel {
  final int id;
  final String amount;
  final String senderName;
  final String recipientName;
  final String senderEmail;
  final String recipientEmail;
  final String recipientMobileNumber;
  final String? senderDate;
  final String message;
  final String? clientId;
  final String eCardId;
  final int createdAt;
  final String donorId;
  final String senderMobileNumber;
  final String checkoutId;
  final int status;
  final String sendWhenFinished;

  ECardModel({
    required this.id,
    required this.amount,
    required this.senderName,
    required this.recipientName,
    required this.senderEmail,
    required this.recipientEmail,
    required this.recipientMobileNumber,
    required this.senderDate,
    required this.message,
    required this.clientId,
    required this.eCardId,
    required this.createdAt,
    required this.donorId,
    required this.senderMobileNumber,
    required this.checkoutId,
    required this.status,
    required this.sendWhenFinished,
  });

  factory ECardModel.fromJson(Map<String, dynamic> json) {
    return ECardModel(
      id: json['id'] ?? 0,
      amount: json['amount']?.toString() ?? "",
      senderName: json['sender_name'] ?? "",
      recipientName: json['recipient_name'] ?? "",
      senderEmail: json['sender_email'] ?? "",
      recipientEmail: json['recipient_email'] ?? "",
      recipientMobileNumber: json['recipient_mobile_number'] ?? "",
      senderDate: json['sender_date'],
      message: json['message'] ?? "",
      clientId: json['client_id'],
      eCardId: json['e_card_id'] ?? "",
      createdAt: json['created_at'] ?? 0,
      donorId: json['donor_id'] ?? "",
      senderMobileNumber: json['sender_mobile_number'] ?? "",
      checkoutId: json['checkout_id'] ?? "",
      status: json['status'] ?? 0,
      sendWhenFinished: json['send_when_finished'] ?? "",
    );
  }
}

class CheckoutModel {
  final bool status;
  final HyperPayCheckoutInner data;

  CheckoutModel({required this.status, required this.data});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      status: json['status'] ?? false,
      data: HyperPayCheckoutInner.fromJson(json['data'] ?? {}),
    );
  }
}



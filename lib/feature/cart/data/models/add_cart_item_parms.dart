class AddCartItemParms {
  final String programId;
  final String id;
  final String donation;
  final String? campaign;
  final String recurrence;
  final int type;
  final int quantity;
  final double amount;

  AddCartItemParms({
    required this.programId,
    required this.id,
    required this.donation,
    this.campaign,
    required this.recurrence,
    required this.type,
    required this.quantity,
    required this.amount,
  });

  /// Convert model to JSON (for API request)
  Map<String, dynamic> toJson({int index = 0}) {
    return {
      'items[$index][program_id]': programId,
      'items[$index][id]': id,
      'items[$index][donation]': donation,
      'items[$index][campaign]': campaign ?? '',
      'items[$index][recurrence]': recurrence,
      'items[$index][type]': type,
      'items[$index][quantity]': quantity.toString(),
      'items[$index][amount]': amount.toString(),
    };
  }

  /// If you ever get response back as plain JSON (not indexed)
  factory AddCartItemParms.fromJson(Map<String, dynamic> json) {
    return AddCartItemParms(
      programId: json['program_id']?.toString() ?? '',
      id: json['id']?.toString() ?? '',
      donation: json['donation']?.toString() ?? '',
      campaign: json['campaign']?.toString(),
      recurrence: json['recurrence']?.toString() ?? '',
      type: json['type'],
      quantity: int.tryParse(json['quantity']?.toString() ?? '1') ?? 1,
      amount: double.tryParse(json['amount']?.toString() ?? '0') ?? 0,
    );
  }
}

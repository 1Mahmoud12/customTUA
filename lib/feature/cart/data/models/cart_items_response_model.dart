class CartItemsResponseModel {
  final bool success;
  final String? message;
  final CartData? data;

  CartItemsResponseModel({required this.success, this.message, this.data});

  factory CartItemsResponseModel.fromJson(Map<String, dynamic> json) {
    return CartItemsResponseModel(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null ? CartData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'success': success, 'message': message, 'data': data?.toJson()};
}

class CartData {
  final int? itemsCount;
  final String? subTotal;
  final String? total;
  final List<dynamic>? users;
  final List<CartItem> items;

  CartData({this.itemsCount, this.subTotal, this.total, this.users, required this.items});

  factory CartData.fromJson(Map<String, dynamic> json) {
    final itemsMap = json['items'] as Map<String, dynamic>? ?? {};
    final itemsList =
        itemsMap.entries.map((entry) => CartItem.fromJson(entry.value)..uniqueKey = entry.key).toList();

    return CartData(
      itemsCount: json['items_count'],
      subTotal: json['sub_total'],
      total: json['total'],
      users: json['users'] != null ? List<dynamic>.from(json['users']) : [],
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() => {
    'items_count': itemsCount,
    'sub_total': subTotal,
    'total': total,
    'users': users,
    'items': {for (var e in items) e.uniqueKey ?? '': e.toJson()},
  };
}

class CartItem {
  String? uniqueKey; // e.g. "7d45c17f-...--monthly"
  String? programId;
  String? id;
  String? donation;
  String? campaign;
  String? recurrence;
  String? type;
  int? quantity;
  num? amountJod;
  num? amountUsd;
  String? title;
  String? image;
  num? totalJod;
  num? totalUsd;
  String? amount;
  String? total;

  CartItem({
    this.uniqueKey,
    this.programId,
    this.id,
    this.donation,
    this.campaign,
    this.recurrence,
    this.type,
    this.quantity,
    this.amountJod,
    this.amountUsd,
    this.title,
    this.image,
    this.totalJod,
    this.totalUsd,
    this.amount,
    this.total,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    programId: json['program_id'],
    id: json['id'],
    donation: json['donation'],
    campaign: json['campaign'],
    recurrence: json['recurrence'],
    type: json['type'],
    quantity: json['quantity'],
    amountJod: json['amount_jod'],
    amountUsd: json['amount_usd'],
    title: json['title'],
    image: json['image'],
    totalJod: json['total_jod'],
    totalUsd: json['total_usd'],
    amount: json['amount'],
    total: json['total'],
  );

  Map<String, dynamic> toJson() => {
    'program_id': programId,
    'id': id,
    'donation': donation,
    'campaign': campaign,
    'recurrence': recurrence,
    'type': type,
    'quantity': quantity,
    'amount_jod': amountJod,
    'amount_usd': amountUsd,
    'title': title,
    'image': image,
    'total_jod': totalJod,
    'total_usd': totalUsd,
    'amount': amount,
    'total': total,
  };
}

class LookupModel {
  LookupModel({required this.success, required this.message, required this.data});

  final bool? success;
  final String? message;
  final LookupData? data;

  factory LookupModel.fromJson(Map<String, dynamic> json) {
    return LookupModel(success: json['success'], message: json['message'], data: json['data'] == null ? null : LookupData.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() => {'success': success, 'message': message, 'data': data?.toJson()};
}

class LookupData {
  LookupData({
    required this.currentCurrency,
    required this.nationalities,
    required this.residencies,
    required this.genders,
    required this.bmsCategories,
  });

  final String? currentCurrency;
  final List<LookupItem>? nationalities;
  final List<LookupItem>? residencies;
  final List<GenderItem>? genders;
  final Map<String, String>? bmsCategories;

  factory LookupData.fromJson(Map<String, dynamic> json) {
    return LookupData(
      currentCurrency: json['current_currency'],
      nationalities: (json['nationalities'] as List?)?.map((e) => LookupItem.fromJson(e as Map<String, dynamic>)).toList(),
      residencies: (json['residencies'] as List?)?.map((e) => LookupItem.fromJson(e as Map<String, dynamic>)).toList(),
      genders: (json['genders'] as List?)?.map((e) => GenderItem.fromJson(e as Map<String, dynamic>)).toList(),
      bmsCategories: (json['bms_categories'] as Map?)?.map((key, value) => MapEntry(key.toString(), value.toString())),
    );
  }

  Map<String, dynamic> toJson() => {
    'current_currency': currentCurrency,
    'nationalities': nationalities?.map((e) => e.toJson()).toList(),
    'residencies': residencies?.map((e) => e.toJson()).toList(),
    'genders': genders?.map((e) => e.toMap()).toList(),
    'bms_categories': bmsCategories,
  };
}

class LookupItem {
  LookupItem({required this.id, required this.name});

  final int id; // can be int or string per API (e.g., genders use string id)
  final String? name;

  factory LookupItem.fromJson(Map<String, dynamic> json) {
    return LookupItem(id: json['id'], name: json['name']?.toString());
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class GenderItem {
  final String id;
  final String name;

  GenderItem({required this.id, required this.name});

  factory GenderItem.fromJson(Map<String, dynamic> json) {
    return GenderItem(id: json['id'], name: json['name']);
  }

  Map<String, String> toMap() {
    return {'id': id, 'name': name};
  }
}

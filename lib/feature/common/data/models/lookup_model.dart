class LookupModel {
  LookupModel({required this.success, required this.message, required this.data});

  final bool? success;
  final String? message;
  final LookupData? data;

  factory LookupModel.fromJson(Map<String, dynamic> json) {
    return LookupModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] == null ? null : LookupData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class LookupData {
  LookupData({
    required this.currentCurrency,
    required this.nationalities,
    required this.residencies,
    required this.genders,
    required this.bmsCategories,
    this.quickDonation,
    this.zakatCalculation,  // ADDED
    this.basicPagesSlug,    // ADDED
  });

  final String? currentCurrency;
  final List<LookupItem>? nationalities;
  final List<LookupItem>? residencies;
  final List<GenderItem>? genders;
  final Map<String, String>? bmsCategories;
  final QuickDonationLookup? quickDonation;
  final ZakatCalculation? zakatCalculation;  // ADDED
  final List<String>? basicPagesSlug;        // ADDED

  factory LookupData.fromJson(Map<String, dynamic> json) {
    final quickDonationRaw = json['quick_donation'];
    QuickDonationLookup? quickDonation;
    if (quickDonationRaw is Map<String, dynamic>) {
      quickDonation = QuickDonationLookup.fromJson(quickDonationRaw);
    } else if (quickDonationRaw != null) {
      quickDonation = QuickDonationLookup(id: quickDonationRaw.toString());
    }

    return LookupData(
      currentCurrency: json['current_currency'],
      nationalities: (json['nationalities'] as List?)?.map((e) => LookupItem.fromJson(e as Map<String, dynamic>)).toList(),
      residencies: (json['residencies'] as List?)?.map((e) => LookupItem.fromJson(e as Map<String, dynamic>)).toList(),
      genders: (json['genders'] as List?)?.map((e) => GenderItem.fromJson(e as Map<String, dynamic>)).toList(),
      bmsCategories: (json['bms_categories'] as Map?)?.map((key, value) => MapEntry(key.toString(), value.toString())),
      quickDonation: quickDonation,
      zakatCalculation: json['zakat_calculation'] == null ? null : ZakatCalculation.fromJson(json['zakat_calculation']),  // ADDED
      basicPagesSlug: (json['basic_pages_slug'] as List?)?.map((e) => e.toString()).toList(),  // ADDED
    );
  }

  Map<String, dynamic> toJson() => {
    'current_currency': currentCurrency,
    'nationalities': nationalities?.map((e) => e.toJson()).toList(),
    'residencies': residencies?.map((e) => e.toJson()).toList(),
    'genders': genders?.map((e) => e.toMap()).toList(),
    'bms_categories': bmsCategories,
    'quick_donation': quickDonation?.toJson(),
    'zakat_calculation': zakatCalculation?.toJson(),  // ADDED
    'basic_pages_slug': basicPagesSlug,               // ADDED
  };
}

class LookupItem {
  LookupItem({required this.id, required this.name});

  final int id;
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

class QuickDonationLookup {
  final String? id;
  final List<QuickDonationItem>? items;
  final String? programId;
  final String? itemId;
  final String? donationGuid;
  final String? campaignGuid;

  const QuickDonationLookup({
    this.id,
    this.items,
    this.programId,
    this.itemId,
    this.donationGuid,
    this.campaignGuid,
  });

  factory QuickDonationLookup.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] as Map<String, dynamic>?;

    final parsedItems = itemsJson != null
        ? itemsJson.entries
        .map((e) => QuickDonationItem.fromJson(e.key, e.value))
        .toList()
        : null;

    return QuickDonationLookup(
      id: json['id']?.toString(),
      programId: json['program_id']?.toString(),
      itemId: json['item_id']?.toString(),
      donationGuid: json['donation']?.toString(),
      campaignGuid: json['campaign']?.toString(),
      items: parsedItems,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> itemsMap = {};

    if (items != null) {
      for (var item in items!) {
        itemsMap[item.key] = item.value;
      }
    }

    return {
      'id': id,
      'items': itemsMap,
      'program_id': programId,
      'item_id': itemId,
      'donation': donationGuid,
      'campaign': campaignGuid,
    };
  }
}

class QuickDonationItem {
  final String key;
  final int value;

  const QuickDonationItem({
    required this.key,
    required this.value,
  });

  factory QuickDonationItem.fromJson(String key, dynamic value) {
    return QuickDonationItem(
      key: key,
      value: int.tryParse(value.toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    key: value,
  };
}

// ADDED: New class for zakat_calculation
class ZakatCalculation {
  final double? nisab;
  final double? zakatPercentage;
  final double? usdToJod;

  const ZakatCalculation({
    this.nisab,
    this.zakatPercentage,
    this.usdToJod,
  });

  factory ZakatCalculation.fromJson(Map<String, dynamic> json) {
    return ZakatCalculation(
      nisab: json['nisab']?.toDouble(),
      zakatPercentage: json['zakat_percentage']?.toDouble(),
      usdToJod: json['usd_to_jod']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'nisab': nisab,
    'zakat_percentage': zakatPercentage,
    'usd_to_jod': usdToJod,
  };
}
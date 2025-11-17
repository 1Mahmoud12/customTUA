class DonationProgramDetailsModel {
  final int id;
  final String title;
  final int? type;
  final String? typeStr;
  final String? slug;
  final String? brief;
  final double? raised;
  final double? goal;
  final double? progress;
  final int? hasGoal;
  final int? isRecurring;
  final int? hasAmount;
  final int? viewOnly;
  final String? color;
  final String? tag;
  final String? tagIcon;
  final String? image;
  final String? fatwaFile;
  final String? campaignReport;
  final List<DonationTabModel>? tabs;
  final List<DonationItemModel>? items;
  final Map<String, String>? recurringTypes;
  final List<RelatedDonationProgramModel>? relatedDonationPrograms;

  DonationProgramDetailsModel({
    required this.id,
    required this.title,
    this.type,
    this.typeStr,
    this.slug,
    this.brief,
    this.raised,
    this.goal,
    this.progress,
    this.hasGoal,
    this.isRecurring,
    this.hasAmount,
    this.viewOnly,
    this.color,
    this.tag,
    this.tagIcon,
    this.image,
    this.fatwaFile,
    this.campaignReport,
    this.tabs,
    this.items,
    this.recurringTypes,
    this.relatedDonationPrograms,
  });

  /// Helper function to parse amount strings like "1,320 JOD" to double
  static double? _parseAmountString(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) {
      // Remove currency text and commas, then parse
      final cleaned = value.replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleaned);
    }
    return null;
  }

  factory DonationProgramDetailsModel.fromJson(Map<String, dynamic> json) {
    return DonationProgramDetailsModel(
      id: json['id'],
      title: json['title'] ?? '',
      type: json['type'],
      typeStr: json['type_str'],
      slug: json['slug'],
      brief: json['brief'],
      raised: _parseAmountString(json['raised']),
      goal: _parseAmountString(json['goal']),
      progress: (json['progress'] as num?)?.toDouble(),
      hasGoal: json['has_goal'],
      isRecurring: json['is_recurring'],
      hasAmount: json['has_amount'],
      viewOnly: json['view_only'],
      color: json['color'],
      tag: json['tag'],
      tagIcon: json['tag_icon'],
      image: json['image'],
      fatwaFile: json['fatwa_file'],
      campaignReport: json['campaign_report'],
      tabs: (json['tabs'] as List?)
          ?.map((e) => DonationTabModel.fromJson(e))
          .toList(),
      items: (json['items'] as List?)
          ?.map((e) => DonationItemModel.fromJson(e))
          .toList(),
      recurringTypes: (json['recurring_types'] as Map?)?.map(
            (key, value) => MapEntry(key.toString(), value.toString()),
      ),
      relatedDonationPrograms: (json['related_donation_programs'] as List?)
          ?.map((e) => RelatedDonationProgramModel.fromJson(e))
          .toList(),
    );
  }
}

class DonationTabModel {
  final int id;
  final String title;
  final String? labelUrl;
  final String? brief;

  DonationTabModel({
    required this.id,
    required this.title,
    this.labelUrl,
    this.brief,
  });

  factory DonationTabModel.fromJson(Map<String, dynamic> json) {
    return DonationTabModel(
      id: json['id'],
      title: json['title'] ?? '',
      labelUrl: json['label_url'],
      brief: json['brief'],
    );
  }
}

class DonationItemModel {
  final int id;
  final String title;
  final double? amountUsd;
  final double? amountJod;
  final String? donationTypeGuid;
  final int? donationTypeId;
  final String? donationType;
  final String? donationTypeCms;
  final String? campaign;
  final int? campaignId;
  final String? campaignGuid;
  final int? order;

  DonationItemModel({
    required this.id,
    required this.title,
    this.amountUsd,
    this.amountJod,
    this.donationTypeGuid,
    this.donationTypeId,
    this.donationType,
    this.donationTypeCms,
    this.campaign,
    this.campaignId,
    this.campaignGuid,
    this.order,
  });

  factory DonationItemModel.fromJson(Map<String, dynamic> json) {
    return DonationItemModel(
      id: json['id'],
      title: json['title'] ?? '',
      amountUsd: (json['amount_usd'] as num?)?.toDouble(),
      amountJod: (json['amount_jod'] as num?)?.toDouble(),
      donationTypeGuid: json['donation_type_guid'],
      donationTypeId: json['donation_type_id'],
      donationType: json['donation_type'],
      donationTypeCms: json['donation_type_cms'],
      campaign: json['campaign'],
      campaignId: json['campaign_id'],
      campaignGuid: json['campaign_guid'],
      order: json['order'],
    );
  }
}

class RelatedDonationProgramModel {
  final int id;
  final String title;
  final String? brief;
  final String? image;
  final List<DonationItemModel>? items;

  RelatedDonationProgramModel({
    required this.id,
    required this.title,
    this.brief,
    this.image,
    this.items,
  });

  factory RelatedDonationProgramModel.fromJson(Map<String, dynamic> json) {
    return RelatedDonationProgramModel(
      id: json['id'],
      title: json['title'] ?? '',
      brief: json['brief'],
      image: json['image'],
      items: (json['items'] as List?)
          ?.map((e) => DonationItemModel.fromJson(e))
          .toList(),
    );
  }
}

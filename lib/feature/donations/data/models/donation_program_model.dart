class DonationProgramModel {
  final int id;
  final String title;
  final String color;
  final String tagIcon;
  final String? campaignReport;
  final String image;

  DonationProgramModel({
    required this.id,
    required this.title,
    required this.color,
    required this.tagIcon,
    required this.image,
    this.campaignReport,
  });

  factory DonationProgramModel.fromJson(Map<String, dynamic> json) {
    return DonationProgramModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      color: json['color'] ?? '',
      tagIcon: json['tag_icon'] ?? '',
      image: json['image'] ?? '',
      campaignReport: json['campaign_report'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['color'] = color;
    data['tag_icon'] = tagIcon;
    data['image'] = image;
    if (campaignReport != null) {
      data['campaign_report'] = campaignReport;
    }
    return data;
  }
}

class DonationProgramModel {
  final int id;
  final String title;
  final String color;
  final String tagIcon;
  final String? campaignReport;
  final String image;
  final String raised;
  final String goal;
  final int progress;

  DonationProgramModel({
    required this.id,
    required this.title,
    required this.color,
    required this.tagIcon,
    required this.image,
    this.campaignReport,
    required this.raised,
    required this.goal,
    required this.progress,
  });

  factory DonationProgramModel.fromJson(Map<String, dynamic> json) {
    return DonationProgramModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      color: json['color'] ?? '',
      raised: json['raised'] ?? '',
      goal: json['goal'] ?? '',
      progress: json['progress'] ?? '',
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
    data['raised'] = raised;
    data['goal'] = goal;
    data['progress'] = progress;
    if (campaignReport != null) {
      data['campaign_report'] = campaignReport;
    }
    return data;
  }
}

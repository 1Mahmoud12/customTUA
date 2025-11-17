class ProgramTagResponseModel {
  final bool success;
  final String? message;
  final List<ProgramTagModel> data;

  ProgramTagResponseModel({
    required this.success,
    this.message,
    required this.data,
  });

  factory ProgramTagResponseModel.fromJson(Map<String, dynamic> json) {
    return ProgramTagResponseModel(
      success: json['success'] ?? false,
      message: json['message'],
      data: (json['data'] as List?)
              ?.map((e) => ProgramTagModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class ProgramTagModel {
  final String title;
  final String color;
  final String tagIcon;

  ProgramTagModel({
    required this.title,
    required this.color,
    required this.tagIcon,
  });

  factory ProgramTagModel.fromJson(Map<String, dynamic> json) {
    return ProgramTagModel(
      title: json['title'] ?? '',
      color: json['color'] ?? '#000000',
      tagIcon: json['tag_icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'color': color,
        'tag_icon': tagIcon,
      };
}


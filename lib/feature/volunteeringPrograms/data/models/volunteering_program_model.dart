class VolunteeringProgramsResponseModel {
  final bool success;
  final String? message;
  final List<VolunteeringProgramModel> data;

  VolunteeringProgramsResponseModel({
    required this.success,
    this.message,
    required this.data,
  });

  factory VolunteeringProgramsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return VolunteeringProgramsResponseModel(
      success: json['success'] ?? false,
      message: json['message'],
      data:
          (json['data'] as List?)
              ?.map(
                (e) => VolunteeringProgramModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
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

class VolunteeringProgramModel {
  final int id;
  final String slug;
  final String title;
  final String brief;
  final String image;
  final String? fileLabel;

  VolunteeringProgramModel({
    required this.id,
    required this.slug,
    required this.title,
    required this.brief,
    required this.image,
    this.fileLabel,
  });

  factory VolunteeringProgramModel.fromJson(Map<String, dynamic> json) {
    return VolunteeringProgramModel(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      title: json['title'] ?? '',
      brief: json['brief'] ?? '',
      image: json['image'] ?? '',
      fileLabel: json['file_label'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'slug': slug,
    'title': title,
    'brief': brief,
    'image': image,
    'file_label': fileLabel,
  };
}

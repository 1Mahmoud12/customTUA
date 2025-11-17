class ECardsResponseModel {
  final bool success;
  final String? message;
  final List<ECardModel> data;

  ECardsResponseModel({
    required this.success,
    this.message,
    required this.data,
  });

  factory ECardsResponseModel.fromJson(Map<String, dynamic> json) {
    return ECardsResponseModel(
      success: json['success'] ?? false,
      message: json['message'],
      data: (json['data'] as List?)
              ?.map((e) => ECardModel.fromJson(e as Map<String, dynamic>))
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

class ECardModel {
  final int id;
  final String slug;
  final String title;
  final String image;

  ECardModel({
    required this.id,
    required this.slug,
    required this.title,
    required this.image,
  });

  factory ECardModel.fromJson(Map<String, dynamic> json) {
    return ECardModel(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'slug': slug,
        'title': title,
        'image': image,
      };
}


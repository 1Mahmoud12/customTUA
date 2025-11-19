// donation_type_model.dart
class DonationTypeModel {
  final int id;
  final String? slug;
  final String guid;
  final String title;
  final String? cmsTitle;
  final String? image;

  DonationTypeModel({
    required this.id,
    this.slug,
    required this.guid,
    required this.title,
    this.cmsTitle,
    this.image,
  });

  factory DonationTypeModel.fromJson(Map<String, dynamic> json) {
    return DonationTypeModel(
      id: json['id'] as int,
      slug: json['slug'] as String?,
      guid: json['guid'] as String,
      title: json['title'] as String,
      cmsTitle: json['cms_title'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'guid': guid,
      'title': title,
      'cms_title': cmsTitle,
      'image': image,
    };
  }
}

// donation_types_response_model.dart
class DonationTypesResponseModel {
  final bool success;
  final String message;
  final List<DonationTypeModel> data;

  DonationTypesResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DonationTypesResponseModel.fromJson(Map<String, dynamic> json) {
    final dataList = (json['data'] as List)
        .map((e) => DonationTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return DonationTypesResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: dataList,
    );
  }
}

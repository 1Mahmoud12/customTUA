class BasicPageModel {
  final int id;
  final String title;
  final String content;
  final String slug;

  BasicPageModel({required this.id, required this.title, required this.content, required this.slug});

  factory BasicPageModel.fromJson(Map<String, dynamic> json) {
    return BasicPageModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['slug'] = slug;
    return data;
  }
}

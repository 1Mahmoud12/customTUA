class SliderModel {
  SliderModel({this.success, this.message, this.data});

  SliderModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(SliderData.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<SliderData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SliderData {
  num? id;
  String? title;
  String? brief;
  String? secondTitle;
  String? content;
  String? url;
  String? image;
  dynamic icon;

  SliderData({
    this.id,
    this.title,
    this.brief,
    this.secondTitle,
    this.content,
    this.url,
    this.image,
    this.icon,
  });

  SliderData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    brief = json['brief'];
    secondTitle = json['second_title'];
    content = json['content'];
    url = json['url'];
    image = json['image'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['title'] = title;
    map['brief'] = brief;
    map['second_title'] = secondTitle;
    map['content'] = content;
    map['url'] = url;
    map['image'] = image;
    map['icon'] = icon;

    return map;
  }
}

class SliderModel {
  SliderModel({this.status, this.message, this.data});

  SliderModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  bool? status;
  String? message;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({this.id, this.image, this.approved, this.type, this.product, this.restaurant, this.createdAt, this.updatedAt});

  Data.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    approved = json['approved'];
    type = json['type'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    restaurant = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? image;
  bool? approved;
  String? type;
  Product? product;
  num? restaurant;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['approved'] = approved;
    map['type'] = type;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['restaurant'] = restaurant;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class Product {
  Product({this.id, this.name, this.price, this.coverImage});

  Product.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    coverImage = json['cover_image'];
  }

  num? id;
  String? name;
  String? price;
  String? coverImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['cover_image'] = coverImage;
    return map;
  }
}

class DonationsHistoryResponse {
  final bool success;
  final String message;
  final DonationsHistoryData data;

  DonationsHistoryResponse({required this.success, required this.message, required this.data});

  factory DonationsHistoryResponse.fromJson(Map<String, dynamic> json) {
    return DonationsHistoryResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DonationsHistoryData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class DonationsHistoryData {
  final List<DonationItem> donations;
  final FilterForm? filterForm;
  final Map<String, String> users;
  final int pages;
  final int page;

  DonationsHistoryData({
    required this.donations,
    required this.filterForm,
    required this.users,
    required this.pages,
    required this.page,
  });

  factory DonationsHistoryData.fromJson(Map<String, dynamic> json) {
    return DonationsHistoryData(
      donations:
          (json['donations'] as List<dynamic>? ?? []).map((e) => DonationItem.fromJson(e)).toList(),
      filterForm: json['filter_form'] != null ? FilterForm.fromJson(json['filter_form']) : null,
      users: (json['users'] ?? {}).map<String, String>((k, v) => MapEntry(k.toString(), v.toString())),
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'donations': donations.map((e) => e.toJson()).toList(),
      'filter_form': filterForm?.toJson(),
      'users': users,
      'pages': pages,
      'page': page,
    };
  }
}

class DonationItem {
  final String donationID;
  final String donationDate;
  final String donorName;
  final String donationType;
  final num amount;
  final num quantity;
  final String image;
  final String title;

  DonationItem({
    required this.donationID,
    required this.donationDate,
    required this.donorName,
    required this.donationType,
    required this.amount,
    required this.quantity,
    required this.image,
    required this.title,
  });

  factory DonationItem.fromJson(Map<String, dynamic> json) {
    return DonationItem(
      donationID: json['DonationID'] ?? '',
      donationDate: json['DonationDate'] ?? '',
      donorName: json['DonorName'] ?? '',
      donationType: json['DonationType'] ?? '',
      amount: json['Amount'] ?? 0,
      quantity: json['Quantity'] ?? 0,
      image: json['image'] ?? '',
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DonationID': donationID,
      'DonationDate': donationDate,
      'DonorName': donorName,
      'DonationType': donationType,
      'Amount': amount,
      'Quantity': quantity,
      'image': image,
      'title': title,
    };
  }
}

class FilterForm {
  final String startDate;
  final String endDate;
  final String name;

  FilterForm({required this.startDate, required this.endDate, required this.name});

  factory FilterForm.fromJson(Map<String, dynamic> json) {
    return FilterForm(
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'start_date': startDate, 'end_date': endDate, 'name': name};
  }
}

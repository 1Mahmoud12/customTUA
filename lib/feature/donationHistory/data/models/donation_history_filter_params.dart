class DonationHistoryFilterParams {
  final String? startDate;
  final String? endDate;
  final String? name;

  DonationHistoryFilterParams({this.startDate, this.endDate, this.name});

  Map<String, dynamic> toJson() {
    return {
      'DonationHistoryFilterForm[start_date]': startDate??'',
      'DonationHistoryFilterForm[end_date]': endDate??'',
      'DonationHistoryFilterForm[name]': name??'',
    };
  }
}

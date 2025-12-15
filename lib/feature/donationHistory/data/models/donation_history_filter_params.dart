class DonationHistoryFilterParams {
  final String? startDate;
  final String? endDate;
  final String? name;

  DonationHistoryFilterParams({this.startDate, this.endDate, this.name});

  Map<String, dynamic> toJson() {
    return {
      if (startDate != null && startDate != '') 'DonationHistoryFilterForm[start_date]': startDate ?? '',
      if (endDate != null && endDate != '') 'DonationHistoryFilterForm[end_date]': endDate ?? '',
      if (name != null && name != '') 'DonationHistoryFilterForm[name]': name ?? '',
    };
  }
}

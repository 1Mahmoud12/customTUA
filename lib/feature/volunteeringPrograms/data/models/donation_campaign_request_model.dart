class DonationCampaignRequestModel {
  final String name;
  final String mobileNumber;
  final String email;
  final String campaignName;
  final String startDate;
  final String endDate;
  final String donationTypeId;
  final String message;
  final String eCardId;

  DonationCampaignRequestModel({
    required this.name,
    required this.mobileNumber,
    required this.email,
    required this.campaignName,
    required this.startDate,
    required this.endDate,
    required this.donationTypeId,
    required this.message,
    required this.eCardId,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'mobile_number': mobileNumber,
        'email': email,
        'campaing_name': campaignName,
        'start_date': startDate,
        'end_date': endDate,
        'donation_type_id': donationTypeId,
        'message': message,
        'e_card_id': eCardId,
      };
}


abstract class CreateCampaignState {}

class CreateCampaignInitial extends CreateCampaignState {}

class CreateCampaignLoading extends CreateCampaignState {}

class CreateCampaignSuccess extends CreateCampaignState {}

class CreateCampaignFailure extends CreateCampaignState {
  final String message;

  CreateCampaignFailure(this.message);
}

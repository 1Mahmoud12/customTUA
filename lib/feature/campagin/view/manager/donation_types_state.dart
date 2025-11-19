import '../../../donations/data/models/donation_type_model.dart';

abstract class DonationTypesState {}

class DonationTypesInitial extends DonationTypesState {}

class DonationTypesLoading extends DonationTypesState {}

class DonationTypesLoaded extends DonationTypesState {
  final List<DonationTypeModel> types;
  final bool fromCache;

  DonationTypesLoaded(this.types, {this.fromCache = false});
}

class DonationTypesError extends DonationTypesState {
  final String message;

  DonationTypesError(this.message);
}

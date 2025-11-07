part of 'donation_program_details_cubit.dart';

abstract class DonationProgramDetailsState extends Equatable {
  const DonationProgramDetailsState();

  @override
  List<Object?> get props => [];
}

class DonationProgramDetailsInitial extends DonationProgramDetailsState {}

class DonationProgramDetailsLoading extends DonationProgramDetailsState {}

class DonationProgramDetailsLoaded extends DonationProgramDetailsState {
  final DonationProgramDetailsModel program;

  const DonationProgramDetailsLoaded(this.program);

  @override
  List<Object?> get props => [program];
}

class DonationProgramDetailsError extends DonationProgramDetailsState {
  final String message;

  const DonationProgramDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}

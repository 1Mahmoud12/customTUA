part of 'donation_programs_cubit.dart';

abstract class DonationProgramsState extends Equatable {
  const DonationProgramsState();

  @override
  List<Object?> get props => [];
}

class DonationProgramsInitial extends DonationProgramsState {}

class DonationProgramsLoading extends DonationProgramsState {}

class DonationProgramsLoaded extends DonationProgramsState {
  final List<DonationProgramModel> programs;
  final bool fromCache;

  const DonationProgramsLoaded(this.programs, {this.fromCache = false});

  @override
  List<Object?> get props => [programs, fromCache];
}

class DonationProgramsError extends DonationProgramsState {
  final String message;

  const DonationProgramsError(this.message);

  @override
  List<Object?> get props => [message];
}

class DonationProgramSelected extends DonationProgramsState {
  final DonationProgramModel selected;

  const DonationProgramSelected(this.selected);

  @override
  List<Object?> get props => [selected];
}

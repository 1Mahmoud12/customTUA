part of 'volunteering_programs_cubit.dart';

abstract class VolunteeringProgramsState {}

class VolunteeringProgramsInitial extends VolunteeringProgramsState {}

class VolunteeringProgramsLoading extends VolunteeringProgramsState {}

class VolunteeringProgramsLoaded extends VolunteeringProgramsState {
  final List<VolunteeringProgramModel> programs;
  final List<SliderData> firstSection;
  final List<SliderData> thirdSection;
  final bool fromCache;

  VolunteeringProgramsLoaded({
    required this.programs,
    this.firstSection = const [],
    this.thirdSection = const [],
    this.fromCache = false,
  });
}
class VolunteeringProgramsError extends VolunteeringProgramsState {
  final String message;

  VolunteeringProgramsError(this.message);
}
import 'package:equatable/equatable.dart';

abstract class ProfileUpdateState extends Equatable {
  const ProfileUpdateState();

  @override
  List<Object?> get props => [];
}

class ProfileUpdateInitial extends ProfileUpdateState {}

class ProfileUpdateLoading extends ProfileUpdateState {}

class ProfileUpdateSuccess extends ProfileUpdateState {}

class ProfileUpdateFailure extends ProfileUpdateState {
  final String message;
  const ProfileUpdateFailure(this.message);

  @override
  List<Object?> get props => [message];
}

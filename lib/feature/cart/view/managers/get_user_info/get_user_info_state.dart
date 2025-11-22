
import '../../../data/models/user_info_response_model.dart';

sealed class GetUserInfoState {}

final class GetUserInfoInitial extends GetUserInfoState {}


class GetUserInfoLoading extends GetUserInfoState {}

class GetUserInfoLoaded extends GetUserInfoState {
  final List<SecondaryUserModel> users;
  final bool fromCache;

  GetUserInfoLoaded(this.users, {required this.fromCache});

}

class GetUserInfoError extends GetUserInfoState {
  final String message;

  GetUserInfoError(this.message);

}
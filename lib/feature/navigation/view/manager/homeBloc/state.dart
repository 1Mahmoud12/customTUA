abstract class MainState {}

class MainInitial extends MainState {}

class ChangeInitialState extends MainState {}

class HomeChangeState extends MainState {}

class ChangeThemeState extends MainState {}

class HomeGetAllBranchesLoadingState extends MainState {}

class HomeGetAllBranchesSuccessState extends MainState {}

class HomeGetAllBranchesErrorState extends MainState {
  final String error;

  HomeGetAllBranchesErrorState(this.error);
}

class GetNotificationCountLoadingState extends MainState {}

class GetNotificationCountSuccessState extends MainState {}

class GetNotificationCountErrorState extends MainState {
  String error;

  GetNotificationCountErrorState(this.error);
}

class GetHomeNotificationLoadingState extends MainState {}

class GetHomeNotificationSuccessState extends MainState {}

class GetHomeNotificationErrorState extends MainState {
  String error;

  GetHomeNotificationErrorState(this.error);
}

class ReadHomeOneNotificationState extends MainState {}

class ReadHomeAllNotificationState extends MainState {}
class GetCurrencySuccessState extends MainState {}
class GetCurrencyLoadingState extends MainState {}
class GetCurrencyErrorState extends MainState {
  String error;

  GetCurrencyErrorState(this.error);
}




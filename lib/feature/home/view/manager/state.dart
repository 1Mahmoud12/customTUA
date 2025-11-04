abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetSlidersLoadingState extends HomeState {}

class GetSlidersSuccessState extends HomeState {}

class GetSlidersErrorState extends HomeState {
  final String error;

  GetSlidersErrorState(this.error);
}

class HomeChangeState extends HomeState {}

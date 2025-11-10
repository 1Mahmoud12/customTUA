import 'package:equatable/equatable.dart';

abstract class AddCartItemState  {
  const AddCartItemState();

}

class AddCartItemInitial extends AddCartItemState {}

class AddCartItemLoading extends AddCartItemState {}

class AddCartItemSuccess extends AddCartItemState {}

class AddCartItemFailure extends AddCartItemState {
  final String message;

  const AddCartItemFailure(this.message);

}

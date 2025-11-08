import 'package:equatable/equatable.dart';

abstract class AddCartItemState extends Equatable {
  const AddCartItemState();

  @override
  List<Object?> get props => [];
}

class AddCartItemInitial extends AddCartItemState {}

class AddCartItemLoading extends AddCartItemState {}

class AddCartItemSuccess extends AddCartItemState {}

class AddCartItemFailure extends AddCartItemState {
  final String message;

  const AddCartItemFailure(this.message);

  @override
  List<Object?> get props => [message];
}

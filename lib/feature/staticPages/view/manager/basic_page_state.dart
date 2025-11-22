import 'package:equatable/equatable.dart';

import '../../data/models/basic_page_model.dart';

abstract class BasicPageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BasicPageInitial extends BasicPageState {}

class BasicPageLoading extends BasicPageState {}

class BasicPageLoaded extends BasicPageState {
  final BasicPageModel page;
  final bool fromCache;

  BasicPageLoaded(this.page, {required this.fromCache});

  @override
  List<Object?> get props => [page, fromCache];
}

class BasicPageError extends BasicPageState {
  final String message;

  BasicPageError(this.message);

  @override
  List<Object?> get props => [message];
}

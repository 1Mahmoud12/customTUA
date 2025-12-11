
import '../../data/models/donations_history_response.dart';

abstract class DonationsHistoryState {}

class DonationsHistoryInitial extends DonationsHistoryState {}

class DonationsHistoryLoading extends DonationsHistoryState {}

class DonationsHistoryLoaded extends DonationsHistoryState {
  final DonationsHistoryResponse response;
  final bool fromCache;

  DonationsHistoryLoaded({
    required this.response,
    required this.fromCache,
  });
}

class DonationsHistoryError extends DonationsHistoryState {
  final String message;

  DonationsHistoryError(this.message);
}

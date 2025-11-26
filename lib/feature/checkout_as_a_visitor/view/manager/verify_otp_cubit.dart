
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/feature/checkout_as_a_visitor/data/data_source/checkout_as_visitor_data_source.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit(this._dataSource) : super(VerifyOtpInitial());
  final CheckoutAsVisitorDataSource _dataSource;

  Future<void> verifyOtp(String otp) async {
    emit(VerifyOtpLoading());
    final result = await _dataSource.verifyOtp(otp);
    result.fold(
      (failure) => emit(VerifyOtpError(message: failure.errMessage)),
      (_) => emit(VerifyOtpSuccess()),
    );
  }
}

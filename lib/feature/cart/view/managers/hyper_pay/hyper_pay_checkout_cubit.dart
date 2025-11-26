import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_source/hyper_pay_data_source.dart';

part 'hyper_pay_checkout_state.dart';

class HyperPayCubit extends Cubit<HyperPayState> {
  HyperPayCubit(this._hyperPayDataSource) : super(HyperPayCheckoutInitial());
  final HyperPayDataSource _hyperPayDataSource;

  Future<void> hyperPayCheckout() async {
    emit(HyperPayLoading());
    final result = await _hyperPayDataSource.hyperPayCheckout();
    result.fold(
      (failure) {
        emit(HyperPayCheckoutError(failure.errMessage));
      },
      (checkoutData) {
        hyperPayHandler(checkoutData.id);
      },
    );
  }

  Future<void> hyperPayHandler(String checkoutId) async {
    emit(HyperPayLoading());
    final result = await _hyperPayDataSource.hyperPayHandler(checkoutId);
    result.fold(
      (failure) {
        emit(HyperPayCheckoutError(failure.errMessage));
      },
      (_) {
        emit(HyperPaySuccess());
      },
    );
  }
}

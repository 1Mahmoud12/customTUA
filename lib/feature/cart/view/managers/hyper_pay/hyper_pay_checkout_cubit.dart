import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/errorLoadingWidgets/dialog_loading_animation.dart';
import 'package:tua/feature/cart/view/managers/cart/cart_cubit.dart';

import '../../../data/data_source/hyper_pay_data_source.dart';
import '../../../data/models/hyper_pay_checkout_response.dart';
import '../../../data/models/hyper_pay_config_response.dart';

part 'hyper_pay_checkout_state.dart';

class HyperPayCubit extends Cubit<HyperPayState> {
  HyperPayCubit(this._hyperPayDataSource) : super(HyperPayCheckoutInitial());
  final HyperPayDataSource _hyperPayDataSource;

  HyperPayConfigData? _config;

  HyperPayConfigData? get config => _config;

  Future<void> hyperPayCheckout() async {
    emit(HyperPayLoading());
    final result = await _hyperPayDataSource.hyperPayCheckout();
    result.fold(
      (failure) {
        emit(HyperPayCheckoutError(failure.errMessage));
      },
      (checkoutData) {
        // Emit checkout created state instead of calling handler immediately
        // Handler will be called after payment is completed in WebView
        emit(HyperPayCheckoutCreated(checkoutData));
      },
    );
  }

  Future<void> hyperPayHandler(BuildContext context, String checkoutId, PurchaseType purchaseType) async {
    emit(HyperPayLoading());
    // animationDialogLoading(context);
    final result = await _hyperPayDataSource.hyperPayHandler(checkoutId,purchaseType);
    // closeDialog(context);
    result.fold(
      (failure) {
        customShowToast(context, failure.errMessage);
        emit(HyperPayCheckoutError(failure.errMessage));
      },
      (unit) {
        customShowToast(context, unit);
        // CartCubit.of(context).fetchCartItems();
        emit(HyperPaySuccess());
      },
    );
  }

  Future<void> getHyperPayConfig({String? lang}) async {
    emit(HyperPayConfigLoading());
    final result = await _hyperPayDataSource.getHyperPayConfig(lang: lang);
    result.fold(
      (failure) {
        emit(HyperPayConfigError(failure.errMessage));
      },
      (configData) {
        _config = configData;
        emit(HyperPayConfigLoaded(configData));
      },
    );
  }
}


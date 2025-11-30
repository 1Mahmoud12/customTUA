import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/themes/styles.dart';
import 'package:tua/core/utils/cusotm_container.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/errorLoadingWidgets/empty_widget.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/cart/data/data_source/hyper_pay_data_source.dart';
import 'package:tua/feature/cart/data/models/cart_items_response_model.dart';
import 'package:tua/feature/cart/view/managers/cart/cart_cubit.dart';
import 'package:tua/feature/cart/view/managers/hyper_pay/hyper_pay_checkout_cubit.dart';
import 'package:tua/feature/cart/view/presentation/cart_view_body.dart';
import 'package:tua/feature/cart/view/presentation/hyper_pay_webview.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';

import '../../../../core/component/buttons/custom_text_button.dart';
import '../../../../core/component/custom_divider_widget.dart';
import '../../../../core/network/local/cache.dart';
import '../../../../core/themes/colors.dart';
import '../../../checkout_as_a_visitor/view/presentation/checkout_as_a_visitor_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'cart'.tr(),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400),
        ),
        centerTitle: false,
        leading: const SizedBox(),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            customShowToast(context, state.message, showToastStatus: ShowToastStatus.error);
          }
        },
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          CartItemsResponseModel? cart;

          if (state is CartLoaded) {
            cart = state.cart;
          } else if (cubit.cachedCart != null) {
            cart = cubit.cachedCart;
          }

          // ✅ Show cart when items exist
          if (cart != null && cart.data != null && cart.data!.items.isNotEmpty) {
            final items = cart.data!.items;
            final total = cart.data!.total ?? '0';
            final subTotal = cart.data!.subTotal ?? '';
            final itemsCount = cart.data!.itemsCount ?? 0;

            return Column(
              children: [
                // Scrollable content area
                Expanded(child: CartViewBody(cartItems: items)),

                // Fixed bottom section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomDividerWidget(),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${'total_donations'.tr()}: ',
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: AppColors.cP50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            total,
                            style: Theme.of(
                              context,
                            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: BlocProvider(
                              create: (context) => HyperPayCubit(HyperPayDataSource()),
                              child: Builder(
                                builder: (context) {
                                  return BlocConsumer<HyperPayCubit, HyperPayState>(
                                    listener: (context, state) {
                                      if (state is HyperPayCheckoutError) {
                                        customShowToast(
                                          context,
                                          state.message,
                                          showToastStatus: ShowToastStatus.error,
                                        );
                                      } else if (state is HyperPayConfigError) {
                                        customShowToast(
                                          context,
                                          state.message,
                                          showToastStatus: ShowToastStatus.error,
                                        );
                                      } else if (state is HyperPayCheckoutCreated) {
                                        // Get config from cubit
                                        final cubit = context.read<HyperPayCubit>();
                                        final config = cubit.config;

                                        if (config != null) {
                                          // Navigate to payment WebView
                                          context.navigateToPage(
                                            BlocProvider.value(
                                              value: cubit,
                                              child: HyperPayWebView(
                                                checkoutData: state.checkoutData,
                                                config: config,
                                                purchaseType: PurchaseType.cart,
                                              ),
                                            ),
                                          );
                                        } else {
                                          customShowToast(
                                            context,
                                            'payment_config_error'.tr(),
                                            showToastStatus: ShowToastStatus.error,
                                          );
                                        }
                                      }
                                    },
                                    builder: (context, state) {
                                      final isLoading =
                                          state is HyperPayLoading || state is HyperPayConfigLoading;

                                      return CustomTextButton(
                                        onPress:
                                            isLoading
                                                ? null
                                                : () async {
                                                  if (userCacheValue == null) {
                                                    context.navigateToPage(
                                                      BlocProvider.value(
                                                        value: context.read<HyperPayCubit>(),
                                                        child: const CheckoutAsAVisitorView(),
                                                      ),
                                                    );
                                                    return;
                                                  }

                                                  final cubit = context.read<HyperPayCubit>();

                                                  // Step 1: Fetch config first
                                                  if (cubit.config == null) {
                                                    await cubit.getHyperPayConfig(lang: 'ar');

                                                    // Check if config was loaded successfully
                                                    if (cubit.config == null) {
                                                      return; // Error already shown in listener
                                                    }
                                                  }

                                                  // Step 2: Create checkout session
                                                  await cubit.hyperPayCheckout();
                                                  // WebView will be opened in listener when HyperPayCheckoutCreated is emitted
                                                },
                                        childText: 'donate_securely',
                                        backgroundColor: Colors.transparent,
                                        borderColor: AppColors.cP50,
                                        borderWidth: 2,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextButton(
                              onPress: () {
                                context.navigateToPage(
                                  const NavigationView(),
                                  pageTransitionType: PageTransitionType.fade,
                                );
                              },
                              childText: 'keep_giving',
                              backgroundColor: Colors.transparent,
                              borderColor: AppColors.primaryColor,
                              colorText: AppColors.primaryColor,
                              borderWidth: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            );
          }
          // ❌ Error State
          else if (state is CartError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmptyWidget(data: state.message),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => cubit.fetchCartItems(),
                      child: CustomContainer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.refresh),
                            SizedBox(width: 4.w),
                            Text('retry'.tr(), style: Styles.style12500),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          // ⏳ Loading
          else if (state is CartLoading) {
            return const Center(
              child: Padding(padding: EdgeInsets.symmetric(vertical: 50.0), child: LoadingWidget()),
            );
          }

          // 💤 Empty
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmptyWidget(data: 'cart_empty_message'.tr()),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => cubit.fetchCartItems(),
                    child: CustomContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.refresh),
                          SizedBox(width: 4.w),
                          Text('reload_cart'.tr(), style: Styles.style12500),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

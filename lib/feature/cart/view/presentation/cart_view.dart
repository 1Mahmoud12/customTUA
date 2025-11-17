import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/utils/errorLoadingWidgets/empty_widget.dart';
import 'package:tua/core/utils/cusotm_container.dart';
import 'package:tua/core/themes/styles.dart';
import 'package:tua/feature/cart/data/data_source/cart_data_source_impl.dart';
import 'package:tua/feature/cart/data/models/cart_items_response_model.dart';
import 'package:tua/feature/cart/view/managers/cart/cart_cubit.dart';
import 'package:tua/feature/cart/view/presentation/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(CartDataSourceImpl())..fetchCartItems(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'cart'.tr(),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400),
          ),
          centerTitle: false,
          leading: const SizedBox(),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {},
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
                    Expanded(child: CartViewBody(cartItems: items)),
                    const SizedBox(height: 10),
                    Divider(thickness: 1, color: Colors.grey.shade300),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.h, top: 10.h),
                      child: Column(
                        children: [
                          if (subTotal.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${'sub_total'.tr()}: ',
                                  style: Styles.style14500.copyWith(fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  subTotal,
                                  style: Styles.style14500.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          if (itemsCount > 0) ...[
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${'items_count'.tr()}: ',
                                  style: Styles.style14500.copyWith(fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  itemsCount.toString(),
                                  style: Styles.style14500.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${'total_donations'.tr()}: ',
                                style: Styles.style14500.copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                total,
                                style: Styles.style14500.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: CustomContainer(
                                    child: Center(
                                      child: Text('donate_securely'.tr(), style: Styles.style12500),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: CustomContainer(
                                    child: Center(
                                      child: Text('keep_giving'.tr(), style: Styles.style12500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              // ❌ Error State
              else if (state is CartError) {
                return Center(
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
                );
              }
              // ⏳ Loading
              else if (state is CartLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: LoadingWidget(),
                );
              }

              // 💤 Empty
              return Center(
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
              );
            },
          ),
        ),
      ),
    );
  }
}

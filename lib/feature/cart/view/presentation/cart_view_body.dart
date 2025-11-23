import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart' show CustomPopupMenu;
import 'package:tua/core/themes/colors.dart';
import 'package:tua/feature/cart/data/data_source/get_user_info_data_source.dart';
import 'package:tua/feature/cart/data/models/cart_items_response_model.dart';
import 'package:tua/feature/cart/view/managers/cart/cart_cubit.dart';
import 'package:tua/feature/cart/view/managers/get_user_info/get_user_info_cubit.dart';
import 'package:tua/feature/cart/view/managers/get_user_info/get_user_info_state.dart';
import 'package:tua/feature/cart/view/presentation/widgets/item_cart_widget.dart' show ItemCartWidget;

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key, required this.cartItems});

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<CartCubit>().fetchCartItems(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          BlocBuilder<UserInfoCubit, GetUserInfoState>(
            builder: (context, state) {
              final cubit = context.read<UserInfoCubit>();
              return cubit.users.isNotEmpty
                  ? CustomPopupMenu(
                    nameField: 'select_donor',
                    selectedItem: DropDownModel(
                      name: cubit.users.first.name,
                      value: cubit.users.first.id,
                    ),
                    items: cubit.users.map((e) => DropDownModel(name: e.name, value: e.id)).toList(),
                  )
                  : const SizedBox();
            },
          ),
          const SizedBox(height: 16),
          Text(
            'donations'.tr(),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.greyG600, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Column(children: cartItems.map((e) => ItemCartWidget(cartItem: e)).toList()),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart' show CustomPopupMenu;
import 'package:tua/core/themes/colors.dart';
import 'package:tua/feature/cart/data/models/cart_items_response_model.dart';
import 'package:tua/feature/cart/view/presentation/widgets/item_cart_widget.dart' show ItemCartWidget;

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key, required this.cartItems});
  final List<CartItem> cartItems ;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        CustomPopupMenu(
          nameField: 'select_donor',
          selectedItem: DropDownModel(name: 'select_donor', value: -1),
          items: [
            DropDownModel(name: 'Donor name 1', value: 1),
            DropDownModel(name: 'Donor name 2', value: 2),
            DropDownModel(name: 'Donor name 3', value: 3),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'donations'.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppColors.greyG600, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
         Column(
          children:cartItems.map((e) => ItemCartWidget(cartItem: e)).toList()
        ),
      ],
    );
  }
}

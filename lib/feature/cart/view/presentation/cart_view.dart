import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_divider_widget.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart' show CustomPopupMenu;
import 'package:tua/core/themes/colors.dart';
import 'package:tua/feature/cart/view/presentation/widgets/item_cart_widget.dart' show ItemCartWidget;

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'.tr(), style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400)),
        centerTitle: false,
        leadingWidth: 0,
        leading: const SizedBox(),
      ),
      body: ListView(
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
          Text('donations'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.greyG600, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          const Column(
            children: [
              ItemCartWidget(nameCart: 'child to child', numberOfPayment: 'one_time_payment', value: 10, count: 1),
              ItemCartWidget(nameCart: 'child to child', numberOfPayment: 'one_time_payment', value: 10, count: 2),
              ItemCartWidget(nameCart: 'child to child', numberOfPayment: 'one_time_payment', value: 10, count: 3),
            ],
          ),
        ],
      ),
      persistentFooterButtons: [
        Column(
          children: [
            const CustomDividerWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${'total_donations'.tr()}: ',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w500),
                ),
                Text('300.00 ${'jod'.tr()}', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextButton(
                    onPress: () {},
                    childText: 'donate_securely',
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.cP50,
                    borderWidth: 2,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextButton(
                    onPress: () {},
                    childText: 'keep_giving',
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.primaryColor,
                    colorText: AppColors.primaryColor,
                    borderWidth: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ],
    );
  }
}

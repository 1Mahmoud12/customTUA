import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/themes/colors.dart';

class ItemCartWidget extends StatelessWidget {
  final String nameCart;
  final String numberOfPayment;
  final int value;
  final int count;

  const ItemCartWidget({super.key, required this.nameCart, required this.numberOfPayment, required this.value, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.black100))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nameCart,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  numberOfPayment.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: AppColors.cP50.withAlpha((.5 * 255).toInt()), fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '$value ${'jod'.tr()}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.cBorderButtonColor), bottom: BorderSide(color: AppColors.cBorderButtonColor)),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cP50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(context.locale.languageCode == 'ar' ? 0 : 10),
                        bottomLeft: Radius.circular(context.locale.languageCode == 'ar' ? 0 : 10),
                        topRight: Radius.circular(context.locale.languageCode == 'ar' ? 10 : 0),
                        bottomRight: Radius.circular(context.locale.languageCode == 'ar' ? 10 : 0),
                      ),
                    ),
                    child: const Icon(Icons.remove, color: AppColors.white),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(12),

                    child: Text(
                      count.toString(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cP50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(context.locale.languageCode == 'ar' ? 10 : 0),
                        bottomLeft: Radius.circular(context.locale.languageCode == 'ar' ? 10 : 0),
                        topRight: Radius.circular(context.locale.languageCode == 'ar' ? 0 : 10),
                        bottomRight: Radius.circular(context.locale.languageCode == 'ar' ? 0 : 10),
                      ),
                    ),
                    child: const Icon(Icons.add, color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

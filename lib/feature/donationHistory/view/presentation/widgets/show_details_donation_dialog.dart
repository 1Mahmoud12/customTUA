import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/themes/colors.dart';

Future<void> showDetailsDonationDialog(BuildContext context, {required Function onPress}) async {
  await showDialog(
    context: context,

    builder: (context) {
      return Dialog(insetPadding: const EdgeInsets.symmetric(horizontal: 16), child: SuccessBottomSheet(onPress: onPress));
    },
  );
}

class SuccessBottomSheet extends StatefulWidget {
  final Function onPress;

  const SuccessBottomSheet({super.key, required this.onPress});

  @override
  State<SuccessBottomSheet> createState() => _SuccessBottomSheetState();
}

class _SuccessBottomSheetState extends State<SuccessBottomSheet> {
  bool expanded = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      log('Updated $expanded');

      expanded = true;
      setState(() {});
      log('Updated $expanded');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To our children in jordan and gaza',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${'donation_date'.tr()}: 2024-05-24',
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium?.copyWith(color: AppColors.cP50.withAlpha((.5 * 255).toInt()), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const ItemCartDonationHistoryWidget(nameCart: 'Blanket for Jordan', value: 10, number: 3),
            const ItemCartDonationHistoryWidget(nameCart: 'Blanket for Jordan', value: 10, number: 3),
            const ItemCartDonationHistoryWidget(nameCart: 'Blanket for Jordan', value: 10, number: 3),
            // const ItemCartDonationHistoryWidget(nameCart: 'Blanket for Jordan', value: 10, number: 3),
            //   const ItemCartDonationHistoryWidget(nameCart: 'Blanket for Jordan', value: 10, number: 3),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
              decoration: const BoxDecoration(color: AppColors.cP50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('total'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white, fontWeight: FontWeight.w500)),
                  Text(
                    '20,000 ${'jod'.tr()}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8), child: CustomTextButton(onPress: () {}, childText: 'submit')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
              child: CustomTextButton(onPress: () {}, childText: 'download_as_pdf', borderColor: AppColors.cP50, backgroundColor: AppColors.white),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ItemCartDonationHistoryWidget extends StatelessWidget {
  final String nameCart;
  final double value;
  final int number;

  const ItemCartDonationHistoryWidget({super.key, required this.nameCart, required this.value, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.greyBorderColor))),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nameCart, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$number * $value',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppColors.cP50.withAlpha((.5 * 255).toInt()), fontWeight: FontWeight.w500),
              ),
              Text('${number * value} ${'jod'.tr()}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}

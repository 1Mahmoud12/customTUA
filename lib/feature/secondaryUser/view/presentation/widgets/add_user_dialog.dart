import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/extensions.dart';

Future<void> showAddNewUserDialog(BuildContext context, {required Function onPress}) async {
  await showDialog(
    context: context,

    builder: (context) {
      return Dialog(insetPadding: const EdgeInsets.symmetric(horizontal: 16), child: AddUserSheet(onPress: onPress));
    },
  );
}

class AddUserSheet extends StatefulWidget {
  final Function onPress;

  const AddUserSheet({super.key, required this.onPress});

  @override
  State<AddUserSheet> createState() => _AddUserSheetState();
}

class _AddUserSheetState extends State<AddUserSheet> {
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 16, top: 8),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffB4BBC6)))),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'add_new_user'.tr(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w500),
              ),
            ),
            CustomTextFormField(
              controller: TextEditingController(),
              nameField: 'your_name',
              hintText: 'enter_your_name'.tr(),
              textInputType: TextInputType.name,
            ),
            CustomTextFormField(
              controller: TextEditingController(),
              nameField: 'email',
              hintText: 'enter_your_name'.tr(),
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(),
            Row(
              children: [
                Expanded(
                  child: CustomTextButton(
                    onPress: () {
                      Navigator.pop(context);
                      widget.onPress();
                    },
                    childText: 'add',
                    colorText: AppColors.cP50,
                    borderColor: AppColors.cP50,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextButton(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    childText: 'cancel',
                    colorText: AppColors.cRed900,
                    borderColor: AppColors.cRed900,
                  ),
                ),
              ],
            ),
          ].paddingDirectional(bottom: 8),
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';

class DonationButton extends StatelessWidget {
  const DonationButton({super.key, required this.onTap, required this.cartAction});
  final void Function() onTap;
  final void Function() cartAction;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomTextButton(
            onPress: onTap,
            borderColor: AppColors.cRed900,
            borderWidth: 2,
            colorText: AppColors.white,
            backgroundColor: AppColors.cRed900,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppIcons.unSelectedDonationIc, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                const SizedBox(width: 8),
                Text('donate'.tr(), style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.white)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: cartAction,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.5, color: AppColors.cP50)),
            child: SvgPicture.asset(AppIcons.cartIc),
          ),
        ),
      ],
    );
  }
}

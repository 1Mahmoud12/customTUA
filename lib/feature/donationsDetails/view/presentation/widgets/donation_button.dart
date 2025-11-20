import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/feature/cart/data/data_source/cart_data_source_impl.dart';
import 'package:tua/feature/cart/data/models/add_cart_item_parms.dart';
import 'package:tua/feature/cart/view/managers/add_cart_item/add_cart_item_cubit.dart';

import '../../../../../core/network/local/cache.dart';
import '../../../../cart/view/managers/add_cart_item/add_cart_item_state.dart';
import '../../../../navigation/view/presentation/widgets/login_required_dialog.dart';

class DonationButton extends StatelessWidget {
  const DonationButton({super.key, required this.onTap});
  final void Function() onTap;


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
                SvgPicture.asset(
                  AppIcons.unSelectedDonationIc,
                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                Text(
                  'donate'.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1.5, color: AppColors.cP50),
          ),
          child: SvgPicture.asset(AppIcons.cartIc),
        ),
      ],
    );
  }
}

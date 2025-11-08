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

import '../../../../cart/view/managers/add_cart_item/add_cart_item_state.dart';

class DonationButton extends StatelessWidget {
  const DonationButton({super.key, required this.parms});

  final AddCartItemParms parms;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCartItemCubit(CartDataSourceImpl()),
      child: BlocConsumer<AddCartItemCubit, AddCartItemState>(
        listener: (context, state) {
          if (state is AddCartItemSuccess) {
            customShowToast(context, 'item_added_success'.tr());
          } else if (state is AddCartItemFailure) {
            customShowToast(context, state.message, showToastStatus: ShowToastStatus.error);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddCartItemCubit>();
          return state is AddCartItemLoading
              ? const LoadingWidget(color: AppColors.cRed900)
              : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomTextButton(
                      onPress: () {
                        cubit.addCartItem(parms);
                      },
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
        },
      ),
    );
  }
}

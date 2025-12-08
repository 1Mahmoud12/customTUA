import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/custom_divider_widget.dart';
import 'package:tua/core/component/custom_radio_button.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/cart/data/models/add_cart_item_parms.dart';
import 'package:tua/feature/donations/data/models/donation_program_details_model.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';

import '../../../../../core/component/loadsErros/loading_widget.dart';
import '../../../../../core/utils/custom_show_toast.dart';
import '../../../../cart/data/data_source/cart_data_source_impl.dart';
import '../../../../cart/view/managers/add_cart_item/add_cart_item_cubit.dart';
import '../../../../cart/view/managers/add_cart_item/add_cart_item_state.dart';
import '../../../../cart/view/managers/cart/cart_cubit.dart';

class RelatedStoryWidget extends StatelessWidget {
  final List<RelatedDonationProgramModel> relatedPrograms;

  const RelatedStoryWidget({super.key, required this.relatedPrograms});

  @override
  Widget build(BuildContext context) {
    if (relatedPrograms.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        const SeeAllWidget(title: 'related_story'),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                relatedPrograms.map((program) => ItemRelatedStoryWidget(program: program)).toList(),
          ),
        ),
      ],
    );
  }
}

class ItemRelatedStoryWidget extends StatefulWidget {
  final RelatedDonationProgramModel program;

  const ItemRelatedStoryWidget({super.key, required this.program});

  @override
  State<ItemRelatedStoryWidget> createState() => _ItemRelatedStoryWidgetState();
}

class _ItemRelatedStoryWidgetState extends State<ItemRelatedStoryWidget> {
  int? selectedItemId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * .8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.scaffoldBackGround,
        border: Border.all(color: AppColors.cP50.withAlpha((0.3 * 255).toInt())),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyG700.withAlpha((0.2 * 255).toInt()),
            blurRadius: 30,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: CacheImage(
                  urlImage: widget.program.image ?? '',
                  width: context.screenWidth * .8,
                  height: 160.h,
                  fit: BoxFit.cover,
                  borderRadius: 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                      decoration: BoxDecoration(
                        color: AppColors.cRed900,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppIcons.incidentsIc,
                            colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Incidents'.tr(),
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(AppIcons.shareIc),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.program.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
                if (widget.program.brief != null && widget.program.brief!.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Text(
                    widget.program.brief!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.cP50.withAlpha((.5 * 255).toInt()),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const CustomDividerWidget(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                if (widget.program.items != null && widget.program.items!.isNotEmpty)
                  CustomRadioListButton(
                    items:
                        widget.program.items!.take(2).map((item) {
                          double? amount;
                          if (ConstantsModels.currency.toLowerCase() == 'usd') {
                            amount = item.amountUsd;
                          } else {
                            amount = item.amountJod;
                          }

                          return RadioButtonModel(
                            id: item.id,
                            name:
                                '${amount?.toStringAsFixed(0) ?? 0.0} ${ConstantsModels.currency.tr()}',
                            subtitle: item.title,
                          );
                        }).toList(),
                    onChanged: (value) {
                      selectedItemId = value;
                    },
                  ),
                BlocProvider(
                  create: (context) => AddCartItemCubit(CartDataSourceImpl()),
                  child: BlocConsumer<AddCartItemCubit, AddCartItemState>(
                    listener: (context, state) {
                      if (state is AddCartItemSuccess) {
                        customShowToast(context, 'item_added_success'.tr());
                        context.read<CartCubit>().fetchCartItems();
                      } else if (state is AddCartItemFailure) {
                        customShowToast(
                          context,
                          state.message.tr(),
                          showToastStatus: ShowToastStatus.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      return state is AddCartItemLoading
                          ? const LoadingWidget(color: AppColors.cRed900)
                          : Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child:
                                 CustomTextButton(
                                      onPress: () async{
                                        if (selectedItemId == null) {
                                          customShowToast(
                                            context,
                                            'no_items_selected'.tr(),
                                            showToastStatus: ShowToastStatus.error,
                                          );
                                          return;
                                        }
                                        final selectedItem = widget.program.items!.firstWhere(
                                          (e) => e.id == selectedItemId,
                                        );
                                        final bool success = await context.read<AddCartItemCubit>().addCartItems([
                                          AddCartItemParms(
                                            programId: widget.program.id.toString(),
                                            id: selectedItem.id.toString(),
                                            donation: selectedItem.donationTypeGuid ?? '',
                                            recurrence: 'once',
                                            campaign: selectedItem.campaignGuid ?? '',
                                            type: selectedItem.donationTypeId ?? 0,
                                            quantity: 1,
                                            amount: selectedItem.amountJod ?? 2,
                                          ),
                                        ]);
                                        if (success && context.mounted) {
                                          context.navigateToPage(const NavigationView(customIndex: 2));
                                        }
                                      },
                                      borderColor: AppColors.cRed900,
                                      borderWidth: 2,
                                      colorText: AppColors.cRed900,
                                      childText: 'take_care_of_me'.tr(),
                                    ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () async {
                              if (selectedItemId == null) {
                                customShowToast(
                                  context,
                                  'no_items_selected'.tr(),
                                  showToastStatus: ShowToastStatus.error,
                                );
                                return;
                              }
                              final selectedItem = widget.program.items!.firstWhere(
                                (e) => e.id == selectedItemId,
                              );
                               await context.read<AddCartItemCubit>().addCartItems([
                                AddCartItemParms(
                                  programId: widget.program.id.toString(),
                                  id: selectedItem.id.toString(),
                                  donation: selectedItem.donationTypeGuid ?? '',
                                  recurrence: 'once',
                                  campaign: selectedItem.campaignGuid ?? '',
                                  type: selectedItem.donationTypeId ?? 0,
                                  quantity: 1,
                                  amount: selectedItem.amountJod ?? 2,
                                ),
                              ]);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 1.5, color: AppColors.cP50),
                              ),
                              child: SvgPicture.asset(AppIcons.cartIc),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ].paddingDirectional(bottom: 12),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/utils/custom_show_toast.dart';

import '../../../../../core/component/fields/custom_text_form_field.dart';
import '../../../../../core/component/loadsErros/loading_widget.dart';
import '../../../../../core/network/local/cache.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../cart/data/data_source/cart_data_source_impl.dart';
import '../../../../cart/data/models/add_cart_item_parms.dart';
import '../../../../cart/view/managers/add_cart_item/add_cart_item_cubit.dart';
import '../../../../cart/view/managers/add_cart_item/add_cart_item_state.dart';
import '../../../../cart/view/managers/cart/cart_cubit.dart';
import '../../../../donations/data/models/donation_program_details_model.dart';
import '../../../../navigation/view/presentation/widgets/login_required_dialog.dart';
import '../manager/change_currency_cubit.dart';
import 'donation_button.dart';
import 'item_option_widget.dart';

class DonationBottomPanel extends StatelessWidget {
  final int? selectedAmount;
  final TextEditingController amountController;
  final Function(int) onAmountSelected;
  final VoidCallback onAmountChanged;
  final DonationProgramDetailsModel detailsModel;
  final String? selectedCurrency;

  const DonationBottomPanel({
    super.key,
    required this.selectedAmount,
    required this.amountController,
    required this.onAmountSelected,
    required this.onAmountChanged,
    required this.detailsModel,
    required this.selectedCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: AppColors.cBorderButtonColor, blurRadius: 4, offset: Offset(2, -2)),
        ],
        color: AppColors.scaffoldBackGround,
        border: Border(top: BorderSide(color: AppColors.cBorderButtonColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 5,
        children: [
          if (detailsModel.type == 1) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  [50, 100, 200, 500, 1000].map((amount) {
                    return ItemOptionsWidget(
                      option: amount,
                      isSelected: selectedAmount == amount,
                      onTap: (_) => onAmountSelected(amount),
                    );
                  }).toList(),
            ),
            CustomTextFormField(
              controller: amountController,
              onChange: (_) => onAmountChanged(),
              hintText: 'enter_amount'.tr(),
              textInputType: TextInputType.number,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'JOD',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
          BlocProvider(
            create: (context) => AddCartItemCubit(CartDataSourceImpl()),
            child: BlocConsumer<AddCartItemCubit, AddCartItemState>(
              listener: (context, state) {
                if (state is AddCartItemSuccess) {
                  customShowToast(context, 'item_added_success'.tr());
                  context.read<CartCubit>().fetchCartItems();
                } else if (state is AddCartItemFailure) {
                  customShowToast(context, state.message.tr(), showToastStatus: ShowToastStatus.error);
                }
              },
              builder: (context, state) {
                return state is AddCartItemLoading
                    ? const LoadingWidget(color: AppColors.cRed900)
                    : DonationButton(
                      onTap: () {
                        if (userCacheValue == null) {
                          loginRequiredDialog(context);
                          return;
                        }
                        if (detailsModel.type == 1 && (selectedAmount == null || selectedAmount == 0)) {
                          customShowToast(context, 'please_select_an_amount'.tr());
                          return;
                        }
                        context.read<AddCartItemCubit>().addCartItems(_buildParamsList(context));
                      },
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<AddCartItemParms> _buildParamsList(BuildContext context) {
    // Type 1: Single item only
    if (detailsModel.type == 1) {
      return [
        AddCartItemParms(
          programId: detailsModel.id.toString(),
          id: detailsModel.items!.first.id.toString(),
          donation: detailsModel.items!.first.donationTypeGuid ?? '',
          campaign: detailsModel.items!.first.campaignGuid ?? '',
          recurrence: 'once',
          type: detailsModel.type!,
          quantity: 1,
          amount: double.tryParse(amountController.text) ?? 0,
        ),
      ];
    }

    // Type 2: Multiple items
    final cubit = context.read<ChangeCurrencyCubit>();

    final List<AddCartItemParms> list = [];

    detailsModel.items?.forEach((item) {
      final count = cubit.itemCounts[item.id] ?? 0;
      if (count == 0) return; // Skip items not selected

      final unitAmount = cubit.selectedCurrency == "JOD" ? (item.amountJod ?? 0) : (item.amountUsd ?? 0);

      list.add(
        AddCartItemParms(
          programId: detailsModel.id.toString(),
          id: item.id.toString(),
          donation: item.donationTypeGuid ?? '',
          campaign: item.campaignGuid ?? "",
          recurrence: selectedCurrency ?? '',
          type: detailsModel.type!,
          quantity: count,
          amount: unitAmount, // amount per item
        ),
      );
    });

    return list;
  }
}

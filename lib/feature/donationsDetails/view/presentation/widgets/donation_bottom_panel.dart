import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/component/fields/custom_text_form_field.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../cart/data/models/add_cart_item_parms.dart';
import '../../../../donations/data/models/donation_program_details_model.dart';
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
          BoxShadow(
            color: AppColors.cBorderButtonColor,
            blurRadius: 4,
            offset: Offset(2, -2),
          )
        ],
        color: AppColors.scaffoldBackGround,
        border: Border(
          top: BorderSide(color: AppColors.cBorderButtonColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [50, 100, 200, 500, 1000].map((amount) {
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
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.cP50,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          DonationButton(
            parms: AddCartItemParms(
              programId: detailsModel.id.toString(),
              id: detailsModel.items!.first.id.toString(),
              donation: detailsModel.items?.first.donationTypeGuid ?? '',
              recurrence: selectedCurrency ?? '',
              type: '2',
              quantity: 1,
              campaign: detailsModel.items?.first.campaignGuid,
              amount: int.tryParse(amountController.text) ?? -1,
            ),
          ),
        ],
      ),
    );
  }
}

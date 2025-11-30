import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_switch_button.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/cart/data/models/add_cart_item_parms.dart';
import 'package:tua/feature/cart/view/managers/add_cart_item/add_cart_item_cubit.dart';
import 'package:tua/feature/cart/view/managers/add_cart_item/add_cart_item_state.dart';
import 'package:tua/feature/common/data/models/lookup_model.dart';
import 'package:tua/feature/quickDonation/view/presentation/card_view.dart';

import '../../../cart/data/data_source/hyper_pay_data_source.dart';
import '../../../cart/view/managers/hyper_pay/hyper_pay_checkout_cubit.dart';
import '../../../donationsDetails/view/presentation/widgets/item_option_widget.dart' show ItemOptionsWidget;

class QuickDonationView extends StatefulWidget {
  const QuickDonationView({super.key});

  @override
  State<QuickDonationView> createState() => _QuickDonationViewState();
}

class _QuickDonationViewState extends State<QuickDonationView> {
  int? selectedAmount;
  late final TextEditingController _amountController;
  int _selectedRecurrenceId = 1;

  QuickDonationLookup? get _quickDonation => ConstantsModels.lookupModel?.data?.quickDonation;

  String get _recurrenceKey => _selectedRecurrenceId == 1 ? 'once' : 'monthly';

  @override
  void initState() {
    _amountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountSelected(int amount) {
    setState(() {
      selectedAmount = amount;
      _amountController.text = amount.toString();
    });
  }

  void _onAmountChanged(String value) {
    setState(() {
      selectedAmount = int.tryParse(value);
    });
  }

  void _onDonatePressed(BuildContext context) {
    // if (userCacheValue == null) {
    //   loginRequiredDialog(context);
    //   return;
    // }
    final amount = int.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      customShowToast(context, 'please_select_an_amount'.tr(), showToastStatus: ShowToastStatus.error);
      return;
    }
    final quickDonation = _quickDonation;
    final donationGuid = quickDonation?.donationGuid ?? quickDonation?.id;
    if (donationGuid == null || donationGuid.isEmpty) {
      customShowToast(context, 'quick_donation_not_available'.tr(), showToastStatus: ShowToastStatus.error);
      return;
    }

    final params = AddCartItemParms(
      programId: quickDonation?.programId ?? '',
      id: quickDonation?.itemId ?? '',
      donation: donationGuid,
      campaign: quickDonation?.campaignGuid ?? '',
      recurrence: _recurrenceKey,
      type: 1,
      quantity: 1,
      amount: amount.toDouble(),
    );

    context.read<AddCartItemCubit>().addCartItems([params]);
  }

  @override
  Widget build(BuildContext context) {
    final quickItems = ConstantsModels.lookupModel?.data?.quickDonation?.items ?? [];
    return Scaffold(
      appBar: customAppBar(context: context, title: 'quick_donation'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),

        children: [
          CustomSwitchButton(
            key: ValueKey(_selectedRecurrenceId),
            items: [SwitchButtonModel(title: 'give_once'.tr(), id: 1), SwitchButtonModel(title: 'monthly'.tr(), id: 2)],
            onChange: (value) {
              setState(() {
                _selectedRecurrenceId = value;
              });
            },
            initialIndex: _selectedRecurrenceId,
          ),
          Text('choose_the_amount'.tr(), style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400)),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.spaceAround,
                  children:
                      quickItems.map((item) {
                        return ItemOptionsWidget(
                          option: item.value, // 👈 استخدام value
                          onTap: (selected) {
                            _onAmountSelected(selected);
                          },
                          isSelected: selectedAmount == item.value,
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
          CustomTextFormField(
            controller: _amountController,
            hintText: '',
            nameField: 'amount_value',
            textInputType: TextInputType.number,
            onChange: _onAmountChanged,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            // suffixIcon: Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: Text(
            //     'jod'.tr(),
            //     style: Theme.of(context).textTheme.displayMedium,
            //   ),
            // ),
          ),
          InkWell(
            onTap: () {
              // if (userCacheValue == null) {
              //   loginRequiredDialog(context);
              //   return;
              // }
              final amount = _amountController.text.trim();
              if (amount.isEmpty) {
                customShowToast(context, 'please_select_an_amount'.tr(), showToastStatus: ShowToastStatus.error);
                return;
              }
              final quickDonation = _quickDonation;
              final donorId = quickDonation?.id ?? quickDonation?.donationGuid;

              context.navigateToPage(BlocProvider(
                create: (context) => HyperPayCubit(HyperPayDataSource()),
  child: CardView(amount: amount, donorId: donorId),
), pageTransitionType: PageTransitionType.rightToLeft);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.black100), bottom: BorderSide(color: AppColors.black100)),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.giftIc),
                  const SizedBox(width: 8),
                  Text(
                    'send_as_an_e_card'.tr(),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.cP50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text('this_donation_will_be_allocated_to_support_families_in_need'.tr(), style: Theme.of(context).textTheme.displayMedium),
        ].paddingDirectional(top: 16),
      ),
      persistentFooterButtons: [
        BlocConsumer<AddCartItemCubit, AddCartItemState>(
          listener: (context, state) {
            if (state is AddCartItemSuccess) {
              customShowToast(context, 'item_added_success'.tr());
            } else if (state is AddCartItemFailure) {
              customShowToast(context, state.message.tr(), showToastStatus: ShowToastStatus.error);
            }
          },
          builder: (context, state) {
            if (state is AddCartItemLoading) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: CircularProgressIndicator(color: AppColors.cRed900)),
              );
            }
            return Container(
              padding: const EdgeInsets.only(top: 16),
              decoration: const BoxDecoration(border: Border(top: BorderSide(width: 1, color: AppColors.black100))),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomTextButton(
                      onPress: () => _onDonatePressed(context),
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
                  // const SizedBox(width: 10),
                  // Container(
                  //   padding: const EdgeInsets.all(10),
                  //   decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.5, color: AppColors.cP50)),
                  //
                  //   child: SvgPicture.asset(AppIcons.cartIc),
                  // ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

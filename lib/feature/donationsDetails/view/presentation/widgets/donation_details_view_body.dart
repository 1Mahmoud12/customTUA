import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tua/feature/donations/data/models/donation_program_details_model.dart';

import '../../../../../core/component/custom_divider_widget.dart';
import '../manager/change_currency_cubit.dart';
import 'donation_bottom_panel.dart';
import 'donation_currency_section.dart';
import 'donation_header_section.dart';
import 'donation_tabs_section.dart';

class DonationDetailsViewBody extends StatefulWidget {
  const DonationDetailsViewBody({super.key, required this.detailsModel});

  final DonationProgramDetailsModel detailsModel;

  @override
  State<DonationDetailsViewBody> createState() => _DonationDetailsViewBodyState();
}

class _DonationDetailsViewBodyState extends State<DonationDetailsViewBody> {
  int? selectedAmount;
  String? selectedCurrency;
  final amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 👉 اختر تلقائياً إذا كان فيه عنصر واحد
    final recurringTypes = widget.detailsModel.recurringTypes ?? {};
    if (recurringTypes.length == 1) {
      selectedCurrency = recurringTypes.keys.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeCurrencyCubit(widget.detailsModel),
      child: DefaultTabController(
        length: widget.detailsModel.tabs?.length ?? 0,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DonationHeaderSection(detailsModel: widget.detailsModel),
                      DonationTabsSection(tabs: widget.detailsModel.tabs),
                      const CustomDividerWidget(height: 24),
                      if (widget.detailsModel.type == 2)
                        DonationCurrencySection(
                          detailsModel: widget.detailsModel,
                          onChange: (curr) {
                            setState(() => selectedCurrency = curr);
                            print('Selected currency key: $curr'); // 👈 للتأكد
                          },
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 190.h),
              ],
            ),

            DonationBottomPanel(
              selectedAmount: selectedAmount,
              amountController: amountController,
              onAmountSelected: (value) {
                setState(() {
                  selectedAmount = value;
                  amountController.text = value.toString();
                });
              },
              onAmountChanged: () => setState(() => selectedAmount = null),
              detailsModel: widget.detailsModel,
              selectedCurrency: selectedCurrency,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/select_currency_widget.dart';

import '../../../../../core/component/custom_divider_widget.dart';
import '../../../../donations/data/models/donation_program_details_model.dart';
import '../manager/change_currency_cubit.dart';
import 'currency_widget.dart';

class DonationCurrencySection extends StatefulWidget {
  final DonationProgramDetailsModel detailsModel;
  final Function(String) onChange;

  const DonationCurrencySection({
    super.key,
    required this.detailsModel,
    required this.onChange
  });

  @override
  State<DonationCurrencySection> createState() => _DonationCurrencySectionState();
}

class _DonationCurrencySectionState extends State<DonationCurrencySection> {
  @override
  void initState() {
    super.initState();

    // 👉 إذا كان recurring_types فيه عنصر واحد، اختاره تلقائياً
    final recurringTypes = widget.detailsModel.recurringTypes ?? {};
    if (recurringTypes.length == 1) {
      // استدعي onChange مع الـ key الوحيد
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChange(recurringTypes.keys.first);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final recurringTypes = widget.detailsModel.recurringTypes ?? {};

    return Column(
      children: [
        // 👉 اعرض CurrencyWidget فقط إذا كان عدد العناصر أكثر من واحد
        if (recurringTypes.length > 1) ...[
          CurrencyWidget(
              details: widget.detailsModel,
              onChange: (v) => widget.onChange(v)
          ),
          const CustomDividerWidget(height: 20),
        ],

        SelectCurrencyWidget(detailsModel: widget.detailsModel),
        const CustomDividerWidget(height: 20),
      ],
    );
  }
}
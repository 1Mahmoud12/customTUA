import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/select_currency_widget.dart';

import '../../../../../core/component/custom_divider_widget.dart';
import '../../../../donations/data/models/donation_program_details_model.dart';
import '../manager/change_currency_cubit.dart';
import 'currency_widget.dart';

class DonationCurrencySection extends StatelessWidget {
  final DonationProgramDetailsModel detailsModel;
  final Function(String) onChange;

  const DonationCurrencySection({super.key, required this.detailsModel, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrencyWidget(details: detailsModel, onChange: (v) => onChange(v)),
        const CustomDividerWidget(height: 20),
        const SelectCurrencyWidget(),
        const CustomDividerWidget(height: 20),

      ],
    );
  }
}

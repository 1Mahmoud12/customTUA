import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../navigation/view/manager/homeBloc/cubit.dart';

void showCurrencyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'select_currency'.tr(),
          style: TextStyle(fontFamily: Constants.fontFamily, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 25),
            _buildCurrencyOption(context, 'USD', 'us_dollar'.tr()),
            const SizedBox(height: 12),
            _buildCurrencyOption(context, 'JOD', 'jordanian_dinar'.tr()),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );
    },
  );
}

Widget _buildCurrencyOption(BuildContext context, String currencyCode, String currencyName) {
  return InkWell(
    onTap: () {
      context.read<MainCubit>().changeCurrency(currencyCode);
      Navigator.pop(context);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(currencyName, style: TextStyle(fontFamily: Constants.fontFamily, fontSize: 16)),
          Text(
            currencyCode,
            style: TextStyle(
              fontFamily: Constants.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    ),
  );
}

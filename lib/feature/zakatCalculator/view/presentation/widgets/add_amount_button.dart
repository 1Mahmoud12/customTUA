import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/colors.dart';
import '../manager/zakat_calculator__cubit.dart';

class AddAmountButton extends StatelessWidget {
  const AddAmountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<ZakatCalculatorCubit>().addAmountField();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'add_amount'.tr(),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 14.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(Icons.add, size: 21, color: AppColors.black),
        ],
      ),
    );
  }
}
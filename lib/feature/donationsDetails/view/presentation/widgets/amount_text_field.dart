import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/feature/navigation/view/manager/homeBloc/state.dart';

import '../../../../../core/component/fields/custom_text_form_field.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constants_models.dart';
import '../../../../navigation/view/manager/homeBloc/cubit.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({super.key, required this.amountController, required this.onAmountChanged});

  final TextEditingController amountController;
  final VoidCallback onAmountChanged;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is ChangeCurrencyErrorState) {
          customShowToast(context, state.error, showToastStatus: ShowToastStatus.error);
        }
      },
      builder: (context, state) {
        return CustomTextFormField(
          controller: amountController,
          onChange: (_) => onAmountChanged(),
          hintText: 'enter_amount'.tr(),
          textInputType: TextInputType.number,
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PopupMenuButton<String>(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ConstantsModels.currency,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.cP50,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down, color: AppColors.cP50, size: 20),
                  ],
                ),
              ),
              itemBuilder:
                  (BuildContext context) => [
                    const PopupMenuItem(value: 'JOD', child: Text('JOD')),
                    const PopupMenuItem(value: 'USD', child: Text('USD')),
                  ],
              onSelected: (String value) {
                MainCubit.of(context).changeCurrency(value);
                onAmountChanged();
              },
            ),
          ),
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/themes/colors.dart';
import '../../../../navigation/view/manager/homeBloc/cubit.dart';

void showCurrencyDialog(BuildContext context, {String? currentCurrency}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SelectCurrencyDialog(selectedCurrency: currentCurrency ?? 'USD');
    },
  );
}

class SelectCurrencyDialog extends StatefulWidget {
  const SelectCurrencyDialog({super.key, required this.selectedCurrency});

  final String selectedCurrency;

  @override
  State<SelectCurrencyDialog> createState() => _SelectCurrencyDialogState();
}

class _SelectCurrencyDialogState extends State<SelectCurrencyDialog> {
  String? selectedValue;

  @override
  void initState() {
    selectedValue = widget.selectedCurrency;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    'select_currency'.tr(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),

                  // USD Option
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedValue = 'USD';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                      ),
                      child: ListTile(
                        title: Text('us_dollar'.tr(), style: Theme.of(context).textTheme.displayMedium),
                        trailing: Radio<String>(
                          value: 'USD',
                          activeColor: AppColors.primaryColor,
                          groupValue: selectedValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                        contentPadding: EdgeInsets.only(
                          right: context.locale.languageCode == 'ar' ? 16 : 4,
                          left: context.locale.languageCode == 'ar' ? 4 : 16,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),

                  // JOD Option
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedValue = 'JOD';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                      ),
                      child: ListTile(
                        title: Text(
                          'jordanian_dinar'.tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        trailing: Radio<String>(
                          value: 'JOD',
                          activeColor: AppColors.primaryColor,
                          groupValue: selectedValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                        contentPadding: EdgeInsets.only(
                          right: context.locale.languageCode == 'ar' ? 16 : 4,
                          left: context.locale.languageCode == 'ar' ? 4 : 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Confirm Button
                  CustomTextButton(
                    childText: 'Confirm'.tr(),
                    onPress: () {
                      if (selectedValue != null) {
                        context.read<MainCubit>().changeCurrency(selectedValue!);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

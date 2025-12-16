import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/navigation/view/manager/homeBloc/cubit.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';

import '../../../../donations/view/manager/donation_programs_cubit.dart';

class SelectLanguageDialog extends StatefulWidget {
  const SelectLanguageDialog({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  State<SelectLanguageDialog> createState() => _SelectLanguageDialogState();
}

class _SelectLanguageDialogState extends State<SelectLanguageDialog> {
  int? selectedValue;

  @override
  void initState() {
    selectedValue = widget.selectedIndex;
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
                  Text('Language'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                  // const SizedBox(height: 8),
                  // Text(
                  //   'Select your language'.tr(),
                  //   style: const TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                  const SizedBox(height: 20),

                  // Arabic Option
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedValue = 0;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.withOpacity(0.4))),
                      child: ListTile(
                        //     leading: SvgPicture.asset(AppIcons.LangArabic, width: 24, height: 24),
                        title: Text('العربيه'.tr(), style: Theme.of(context).textTheme.displayMedium),
                        trailing: Radio<int>(
                          value: 0,
                          activeColor: AppColors.primaryColor,
                          groupValue: selectedValue,

                          onChanged: (int? value) {
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

                  // English Option
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedValue = 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.withOpacity(0.4))),
                      child: ListTile(
                        //   leading: SvgPicture.asset(AppIcons.LangEnglish, width: 24, height: 24),
                        title: Text('English'.tr(), style: Theme.of(context).textTheme.displayMedium),
                        trailing: Radio<int>(
                          value: 1,
                          activeColor: AppColors.primaryColor,
                          groupValue: selectedValue,
                          onChanged: (int? value) {
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

                  CustomTextButton(
                    childText: 'confirm'.tr(),
                    onPress: () async{
                      setState(() {
                        if (selectedValue == 0) {
                          MainCubit.of(context).changeLanguage(const Locale('ar', 'SA'), context);
                        } else {
                          MainCubit.of(context).changeLanguage(const Locale('en', 'US'), context);
                        }
                      });
                      Navigator.pop(context);
                      context.read<DonationProgramsCubit>().fetchDonationPrograms();

                      context.navigateToPage(NavigationView());

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

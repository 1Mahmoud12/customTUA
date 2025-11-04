import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart' show CustomPopupMenu;
import 'package:tua/core/themes/colors.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/date_picker_dialog.dart';

import 'widgets/item_donation_history_widget.dart';

class DonationHistoryView extends StatelessWidget {
  const DonationHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'donation_history'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 24),
          CustomPopupMenu(selectedItem: DropDownModel(name: 'select_donor', value: -1), items: const [], nameField: 'donor_name'),
          const SizedBox(height: 22.5),
          Row(
            children: [
              Expanded(
                child: CustomPopupMenu(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => Center(
                            child: BeautifulDatePicker(
                              firstDate: DateTime.now(),
                              onDateSelected: (dateSelected) {
                                print('dateSelected');
                                print(dateSelected);
                              },
                              lastDate: DateTime.now().add(const Duration(days: 100)),
                            ),
                          ),
                    );
                  },
                  nameField: 'from',
                  selectedItem: DropDownModel(name: 'DD/MM/YYYY', value: -1),
                  items: const [],
                  showDropDownIcon: false,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomPopupMenu(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => Center(
                            child: BeautifulDatePicker(
                              firstDate: DateTime.now(),
                              onDateSelected: (dateSelected) {},
                              lastDate: DateTime.now().add(const Duration(days: 100)),
                            ),
                          ),
                    );
                  },
                  nameField: 'to',
                  selectedItem: DropDownModel(name: 'DD/MM/YYYY', value: -1),
                  items: const [],
                  showDropDownIcon: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          const Column(children: [ItemDonationHistoryWidget(), ItemDonationHistoryWidget()]),
        ],
      ),
      persistentFooterButtons: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [BoxShadow(color: AppColors.cShadowColor.withAlpha((.25 * 255).toInt()), blurRadius: 15, offset: const Offset(0, -10))],
          ),
          child: CustomTextButton(onPress: () {}, childText: 'download_as_pdf'.tr()),
        ),
      ],
    );
  }
}

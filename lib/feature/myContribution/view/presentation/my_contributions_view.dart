import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart' show CustomPopupMenu;
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/myContribution/view/presentation/widgets/all_summary_widget.dart' show AllSummaryWidget;
import 'package:tua/feature/myContribution/view/presentation/widgets/item_summary_widget.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/date_picker_dialog.dart' show BeautifulDatePicker;

class MyContributionsView extends StatelessWidget {
  const MyContributionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'my_contributions'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          CustomPopupMenu(
            selectedItem: DropDownModel(name: 'select_donor', value: -1),
            items: [
              DropDownModel(name: 'donor Name 1', value: 1),
              DropDownModel(name: 'donor Name 2', value: 2),
              DropDownModel(name: 'donor Name 3', value: 3),
            ],
            nameField: 'donor_name',
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('my_total_donations'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(width: 10),
                Text('1000 ${'jod'.tr()}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
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
                              onDateSelected: (dateSelected) {},
                              lastDate: DateTime.now().add(const Duration(days: 100)),
                            ),
                          ),
                    );
                  },
                  nameField: 'from',
                  selectedItem: DropDownModel(name: 'DD/MM/YYYY', value: -1),
                  items: const [],
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
                ),
              ),
            ],
          ),
          const ItemSummaryWidget(),
          const ItemSummaryWidget(),
          const AllSummaryWidget(),
        ].paddingDirectional(top: 16),
      ),
    );
  }
}

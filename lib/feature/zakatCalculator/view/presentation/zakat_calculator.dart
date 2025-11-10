import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_divider_widget.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/custom_switch_button.dart';
import 'package:tua/core/component/drop_menu.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/feature/zakatCalculator/view/presentation/widgets/current_nisab_value_widget.dart';
import 'package:tua/feature/zakatCalculator/view/presentation/widgets/detailed_calculate_widget.dart';
import 'package:tua/feature/zakatCalculator/view/presentation/widgets/form_money_widget.dart';
import 'package:tua/feature/zakatCalculator/view/presentation/widgets/quick_calculate_widget.dart';

import '../../../../core/network/local/cache.dart';
import '../../../navigation/view/presentation/widgets/login_required_dialog.dart';

class ZakatCalculatorView extends StatefulWidget {
  const ZakatCalculatorView({super.key});

  @override
  State<ZakatCalculatorView> createState() => _ZakatCalculatorViewState();
}

class _ZakatCalculatorViewState extends State<ZakatCalculatorView> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'zakat_calculator'),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(height: 17),
              CustomSwitchButton(
                onChange: (p0) {
                  _selectedIndex = p0;
                  setState(() {});
                },
                initialIndex: _selectedIndex,
                items: [SwitchButtonModel(title: 'quick_calculator', id: 1), SwitchButtonModel(title: 'detailed_calculator', id: 2)],
              ),
              const SizedBox(height: 16),

              CustomPopupMenu(
                nameField: 'choose_year',
                selectedItem: DropDownModel(name: 'selected_year', value: -1),
                items: [DropDownModel(name: 'islamic_year', value: 1), DropDownModel(name: 'gregorian_year', value: 2)],
              ),
              const SizedBox(height: 24),
              Text('The percentage of Zakat according to the selected year is: 0.025%', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 24),
              if (_selectedIndex == 1) ...[const QuickCalculateWidget()],
              if (_selectedIndex == 2) ...[const DetailedCalculateWidget()],
              const SizedBox(height: 24),
              CustomTextButton(onPress: () {}, childText: 'calculate'),
              const SizedBox(height: 24),
              const CustomDividerWidget(),
              const SizedBox(height: 24),
              const CurrentNisabValueWidget(),
              const SizedBox(height: 24),
              const ForMoneyWidget(),
              const SizedBox(height: 40),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(top: BorderSide(color: Color(0xFFE3E3E3) /* Neutrals-Neutrals100 */)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${'total'.tr()}: ', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400)),
                    Text('1000 ${'jod'.tr()}', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400)),
                  ],
                ),
                const SizedBox(height: 24),
                CustomTextButton(
                  onPress: () {
                    if (userCacheValue==null ) {
                      loginRequiredDialog(context);
                      return;
                    }
                  },
                  backgroundColor: AppColors.cRed900,
                  borderColor: AppColors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.unSelectedDonationIc, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                      const SizedBox(width: 8),
                      Text(
                        'donate_now'.tr(),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

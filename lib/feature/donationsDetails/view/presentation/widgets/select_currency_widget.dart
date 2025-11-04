import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_switch_button.dart';
import 'package:tua/core/themes/colors.dart';

class SelectCurrencyWidget extends StatelessWidget {
  const SelectCurrencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('select_currency'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        CustomSwitchButton(
          expandValue: false,

          items: [SwitchButtonModel(title: 'jod', id: 3), SwitchButtonModel(title: 'usd', id: 1)],
          onChange: (p0) {},
          initialIndex: 0,
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            const ItemValueTrackerCurrencyWidget(currency: 'jod', name: 'Waterproof Jacket', value: 100, count: 1),
            const ItemValueTrackerCurrencyWidget(currency: 'usd', name: 'Waterproof Jacket', value: 100, count: 1),
            const ItemValueTrackerCurrencyWidget(currency: 'jod', name: 'Waterproof Jacket', value: 100, count: 1),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cHumanitarianAidColor.withAlpha((.06 * 255).toInt()),
                borderRadius: BorderRadius.circular(100),
              ),

              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: DottedDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.cHumanitarianAidColor.withAlpha((.5 * 255).toInt()),
                  strokeWidth: 2,
                  dash: const [8, 4],
                  shape: Shape.box,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'total'.tr(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cHumanitarianAidColor),
                    ),
                    Text(
                      '10000 JOD'.tr(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cHumanitarianAidColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ItemValueTrackerCurrencyWidget extends StatefulWidget {
  const ItemValueTrackerCurrencyWidget({super.key, required this.name, required this.value, required this.count, required this.currency});

  final String name;
  final String currency;
  final double value;
  final int count;

  @override
  State<ItemValueTrackerCurrencyWidget> createState() => _ItemValueTrackerCurrencyWidgetState();
}

class _ItemValueTrackerCurrencyWidgetState extends State<ItemValueTrackerCurrencyWidget> {
  int count = 0;

  @override
  void initState() {
    count = widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cBackGroundButtonColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.greyG200, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(
                  '${widget.value.toStringAsFixed(2)} ${widget.currency}',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cHumanitarianAidColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          InkWell(
            onTap: () {
              setState(() {
                if (count > 0) {
                  count--;
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.remove, color: count > 0 ? AppColors.cP50 : AppColors.cP50.withAlpha((.5 * 255).toInt())),
            ),
          ),
          Text(count.toString(), style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              setState(() {
                count++;
              });
            },
            child: Icon(Icons.add, color: AppColors.cP50),
          ),
        ],
      ),
    );
  }
}

class ItemCurrencyWidget extends StatelessWidget {
  const ItemCurrencyWidget({super.key, required this.title, required this.isSelected});

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(color: isSelected ? AppColors.cP100 : Colors.transparent, borderRadius: BorderRadius.circular(50)),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500, color: isSelected ? AppColors.white : AppColors.cP50),
        textAlign: TextAlign.center,
      ),
    );
  }
}

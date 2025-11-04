import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/themes/colors.dart';

class SelectCardWidget extends StatefulWidget {
  const SelectCardWidget({super.key});

  @override
  State<SelectCardWidget> createState() => _SelectCardWidgetState();
}

class _SelectCardWidgetState extends State<SelectCardWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text.rich(
            TextSpan(
              text: 'select_an_e-card_design'.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50),
              children: [
                TextSpan(text: ' ', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700)),
                TextSpan(
                  text: '(${'optional'.tr()})',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50.withAlpha((0.4 * 255).toInt())),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 8),
              ...List.generate(
                3,
                (index) => ItemGiftWidget(
                  index: index,
                  onPress: (p0) {
                    _selectedIndex = p0;
                    setState(() {});
                  },
                  selected: _selectedIndex == index,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }
}

class ItemGiftWidget extends StatefulWidget {
  final bool selected;
  final int index;
  final Function(int) onPress;

  const ItemGiftWidget({super.key, required this.selected, required this.onPress, required this.index});

  @override
  State<ItemGiftWidget> createState() => _ItemGiftWidgetState();
}

class _ItemGiftWidgetState extends State<ItemGiftWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPress(widget.index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: widget.selected == true ? AppColors.cP50 : AppColors.cP50.withAlpha((0.15 * 255).toInt())),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const CacheImage(urlImage: '', width: 100, height: 100, borderRadius: 10),
            const SizedBox(height: 10),

            Container(
              width: 26,
              height: 26,
              // padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.cP50, width: 1.5),
                //  color: selected == true ? AppColors.primaryColor : AppColors.transparent,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),

                width: 12,
                height: 12,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(shape: BoxShape.circle, color: widget.selected == true ? AppColors.cP50 : Colors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

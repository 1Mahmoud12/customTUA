import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_divider_widget.dart';
import 'package:tua/core/component/sliders/slider_custom.dart';
import 'package:tua/core/themes/colors.dart';

class RaisedAndGoalSliderWidget extends StatelessWidget {
  final double raised;
  final double goal;
  final Color? color;

  const RaisedAndGoalSliderWidget({super.key, required this.raised, required this.goal, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('raised'.tr(), style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color ?? AppColors.cRed900)),
                const SizedBox(height: 6),
                Text('$raised ${'JOD'.tr()}'.tr(), style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 4),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('goal'.tr(), style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color ?? AppColors.cRed900)),
                const SizedBox(height: 6),
                Text('$goal ${'JOD'.tr()}'.tr(), style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 4),
              ],
            ),
          ],
        ),
        SliderCustom(valueSlider: (raised / goal) * 100, activeTrackColor: color ?? AppColors.cRed900),
        const CustomDividerWidget(height: 24),
      ],
    );
  }
}

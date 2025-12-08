import 'package:flutter/material.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/extensions.dart';

class SliderCustom extends StatelessWidget {
  final double valueSlider;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;

  const SliderCustom({
    super.key,
    required this.valueSlider,
    this.activeTrackColor,
    this.inactiveTrackColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        const badgeWidth = 55;
        final trackWidth = maxWidth - badgeWidth;

        final activeTrackWidth = (valueSlider / 100) * trackWidth;

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Base track
            Container(
              height: 10,
              width: maxWidth,
              decoration: BoxDecoration(
                color: inactiveTrackColor ?? AppColors.greyG800,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 10,
                  width: activeTrackWidth, // This should be the absolute width in pixels
                  decoration: BoxDecoration(
                    color: activeTrackColor ?? AppColors.cRed900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: activeTrackColor ?? AppColors.cRed900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${valueSlider.toInt()} %',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.scaffoldBackGround,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/*
 Expanded(
          child: SliderTheme(
            dataSource: SliderThemeData(
              thumbShape: const RoundSliderOverlayShape(overlayRadius: 1),
              activeTrackColor: AppColors.selectedCharData,
              inactiveTrackColor: AppColors.cLightPlusNumber,
              // trackHeight: context.screenHeight * .017,

              trackShape: CustomTrackShape(),
            ),
            child: Slider(
              max: 100,
              value: valueSlider,
              thumbColor: CAppColors.transparent,
              onChanged: (value) {
                valueSlider = value;
              },
            ),
          ),
        ),
        Text(
          '$valueSlider %',
          style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
        ),
*/

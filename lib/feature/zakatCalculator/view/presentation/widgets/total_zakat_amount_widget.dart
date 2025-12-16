import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/themes/colors.dart';

class TotalZakatAmountWidget extends StatelessWidget {
  final bool isBelowNisab;
  final double? zakatAmount;
  final double? nisab;

  const TotalZakatAmountWidget({
    super.key,
    this.isBelowNisab = false,
    this.zakatAmount,
    this.nisab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withAlpha((.2 * 255).toInt()),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: DottedDecoration(
          borderRadius: BorderRadius.circular(100),
          color:AppColors.primaryColor.withAlpha((.5 * 255).toInt()),
          strokeWidth: 2,
          dash: const [8, 4],
          shape: Shape.box,
        ),
        child: isBelowNisab ? _buildBelowNisabContent(context) : _buildSuccessContent(context),
      ),
    );
  }

  Widget _buildBelowNisabContent(BuildContext context) {
    return Text(
      '${'sorry_inserted_amount'.tr()} ${nisab?.toStringAsFixed(1)} ${'jod'.tr()}',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w400,
        // color: Colors.red.shade700,
      ),
    );
  }

  Widget _buildSuccessContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            'total_zakat_amount'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${zakatAmount?.toStringAsFixed(2)} ${'jod'.tr()}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/hex_to_color.dart';
import '../../../../donations/data/models/donation_program_details_model.dart';

class ItemValueTrackerCurrencyWidget extends StatelessWidget {
  const ItemValueTrackerCurrencyWidget({
    super.key,
    required this.name,
    required this.value,
    required this.count,
    required this.currency,
    required this.onIncrease,
    required this.onDecrease,
    required this.detailsModel,
  });

  final String name;
  final String currency;
  final double value;
  final int count;
  final DonationProgramDetailsModel detailsModel;

  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

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
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${value.toStringAsFixed(2)} $currency',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color:
                        detailsModel.color != null
                            ? hexToColor(detailsModel.color!)
                            : AppColors.cHumanitarianAidColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // decrease
          InkWell(
            onTap: onDecrease,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.remove,
                color: count > 0 ? AppColors.cP50 : AppColors.cP50.withAlpha((.5 * 255).toInt()),
              ),
            ),
          ),

          // count
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w500),
          ),

          const SizedBox(width: 8),

          // increase
          InkWell(onTap: onIncrease, child: const Icon(Icons.add, color: AppColors.cP50)),
        ],
      ),
    );
  }
}

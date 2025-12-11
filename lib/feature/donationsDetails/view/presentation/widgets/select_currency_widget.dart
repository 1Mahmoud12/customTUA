import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/feature/donationsDetails/view/presentation/manager/change_currency_cubit.dart';

import '../../../../../core/component/custom_switch_button.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/hex_to_color.dart';
import '../../../../donations/data/models/donation_program_details_model.dart';
import 'item_value_tracker_widget.dart';

class SelectCurrencyWidget extends StatelessWidget {
  const SelectCurrencyWidget({super.key, required this.detailsModel});

  final DonationProgramDetailsModel detailsModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeCurrencyCubit, ChangeCurrencyState>(
      builder: (context, state) {
        if (state is! DonationLoaded) {
          return const SizedBox();
        }

        final cubit = context.read<ChangeCurrencyCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Currency switch
            // CustomSwitchButton(
            //   expandValue: false,
            //   items: [
            //     SwitchButtonModel(title: 'JOD', id: 0),
            //     SwitchButtonModel(title: 'USD', id: 1)
            //   ],
            //   onChange: cubit.changeCurrency,
            //   initialIndex: cubit.selectedCurrencyIndex,
            // ),
            const SizedBox(height: 12),

            // Parent tabs (if multiple parents exist and have titles)
            if (_shouldShowParentTabs(state.parents)) ...[
              _buildParentTabs(context, state, cubit),
              const SizedBox(height: 16),
            ],

            // Items list for current parent
            Column(
              children: [
                ...state.items.map((item) {
                  final count = state.counts[item.id] ?? 0;

                  return ItemValueTrackerCurrencyWidget(
                    detailsModel: detailsModel,
                    name: item.title,
                    value: ConstantsModels.currency.toLowerCase() == 'jod'
                        ? item.amountJod ?? 0
                        : item.amountUsd ?? 0,
                    currency: ConstantsModels.currency,
                    count: count,
                    onIncrease: () => cubit.increase(item.id),
                    onDecrease: () => cubit.decrease(item.id),
                  );
                }).toList(),

                // Total UI
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cHumanitarianAidColor.withAlpha((.06 * 255).toInt()),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: DottedDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: detailsModel.color != null
                          ? hexToColor(detailsModel.color!).withAlpha((.5 * 255).toInt())
                          : AppColors.cHumanitarianAidColor.withAlpha((.5 * 255).toInt()),
                      strokeWidth: 2,
                      dash: const [8, 4],
                      shape: Shape.box,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'total'.tr(),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: detailsModel.color != null
                                ? hexToColor(detailsModel.color!)
                                : AppColors.cHumanitarianAidColor,
                          ),
                        ),
                        Text(
                          '${state.total.toStringAsFixed(2)} ${ConstantsModels.currency}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: detailsModel.color != null
                                ? hexToColor(detailsModel.color!)
                                : AppColors.cHumanitarianAidColor,
                          ),
                        ),
                      ],
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

  Widget _buildParentTabs(
      BuildContext context,
      DonationLoaded state,
      ChangeCurrencyCubit cubit,
      ) {
    // Convert parents to switch button items
    final parentItems = state.parents
        .asMap()
        .entries
        .map((entry) => SwitchButtonModel(
      title: entry.value.info?.title ?? 'Parent ${entry.key + 1}',
      id: entry.key,
    ))
        .toList();

    return CustomSwitchButton(
      expandValue: true,
      items: parentItems,
      onChange: cubit.changeParent,
      initialIndex: state.selectedParentIndex,
    );
  }

  /// Check if parent tabs should be shown
  /// Returns true only if there are multiple parents AND at least one has a non-empty title
  bool _shouldShowParentTabs(List<DonationParentGroup> parents) {
    if (parents.length <= 1) return false;

    // Check if any parent has a non-empty title
    return parents.any((parent) =>
    parent.info?.title != null && parent.info!.title.trim().isNotEmpty
    );
  }
}
import 'package:flutter/material.dart';
import 'package:tua/core/utils/navigate.dart';

import '../../../../../core/component/buttons/custom_text_button.dart';
import '../../../../../core/component/custom_check_box.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../donations/view/presentation/add_person_view.dart';

class DonationExtrasSection extends StatelessWidget {
  const DonationExtrasSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCheckBox(
          fillTrueValue: AppColors.cP50,
          borderRadius: 4,
          borderColor: AppColors.cP50,
          onTap: (_) {},
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'I’d like to add 2.4% to help cover transaction fees.',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColors.cP50),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        CustomCheckBox(
          borderRadius: 4,
          fillTrueValue: AppColors.cP50,
          borderColor: AppColors.cP50,
          checkBox: true,
          onTap: (_) {},
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Donate as a gift',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColors.cP50),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        CustomTextButton(
          onPress: () => context.navigateToPage(const AddPersonView()),
          childText: 'add_person',
          backgroundColor: AppColors.white,
          colorText: AppColors.green,
          borderColor: AppColors.green,
        ),
      ],
    );
  }
}

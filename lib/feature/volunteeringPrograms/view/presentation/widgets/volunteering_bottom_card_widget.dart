import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/feature/home/data/model/slider_model.dart';

class VolunteeringBottomCardWidget extends StatelessWidget {
  final List<SliderData> thirdSection;

  const VolunteeringBottomCardWidget({
    super.key,
    required this.thirdSection,
  });

  @override
  Widget build(BuildContext context) {
    final hasData = thirdSection.isNotEmpty;
    final thirdItem = hasData ? thirdSection.first : null;

    // Determine background image source
    final backgroundImage = hasData && thirdItem?.image != null
        ? DecorationImage(
      image: NetworkImage(thirdItem!.image!),
      fit: BoxFit.cover,
    )
        : const DecorationImage(
      image: AssetImage(AppImages.backgroundDownloadAndApply),
      fit: BoxFit.cover,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: backgroundImage,
      ),
      child: Column(
        children: [
          // Title
          Text(
            thirdItem?.title ?? 'Volunteering conditions',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          // Brief Description
          Text(
            thirdItem?.brief ??
                "Before you submit your volunteering application...",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: const Color(0xffF9F9F9),
            ),
          ),
          const SizedBox(height: 16),
          // Download Button
          CustomTextButton(
            onPress: () {
              // Handle download action
              // You can use thirdItem?.url if available
              if (thirdItem?.url != null) {
                // Add navigation or URL launch logic
              }
            },
            childText: 'download',
            backgroundColor: AppColors.white,
            colorText: AppColors.cP50,
          ),
          const SizedBox(height: 16),
          // Apply Now Button
          CustomTextButton(
            onPress: () {
              // Handle apply now action
              // Navigate to application form
            },
            childText: 'apply_now',
            backgroundColor: AppColors.primaryColor,
            borderColor: Colors.transparent,
            colorText: AppColors.white,
          ),
        ],
      ),
    );
  }
}
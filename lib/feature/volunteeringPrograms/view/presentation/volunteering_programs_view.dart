import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/view_all_volunteering_programs_view.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/widgets/item_volunteeing_program_widget.dart';

class VolunteeringProgramsView extends StatelessWidget {
  const VolunteeringProgramsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'volunteering_programs'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  'About Volunteering',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 30),
                const CacheImage(height: 200, width: double.infinity, urlImage: '', fit: BoxFit.cover, borderRadius: 10),
                const SizedBox(height: 30),
                Text(
                  'Volunteer ... Be The Change',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400, color: AppColors.primaryColor),
                ),
                const SizedBox(height: 16),
                Text(
                  'Stemming from Tkiyet Um Ali’s belief in the  importance  of  spreading  awareness  about\nfood poverty, and with an aim  to  enhance  social  solidarity  that  plays  an  instrumental\nand influential part in achieving its goals, TKiyet Um Ali  welcomes  dedicated  volunteers\nstriving to help from all over the Kingdom.',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50),
                ),
                const SizedBox(height: 16),
                SeeAllWidget(
                  padding: EdgeInsets.zero,
                  title: 'volunteering_programs',
                  textStyle: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400),
                  onTap: () {
                    context.navigateToPage(const ViewAllVolunteeringProgramsView());
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  5,
                  (index) => Container(
                    padding: const EdgeInsets.all(8),
                    // decoration: const BoxDecoration(color: AppColors.cBackGroundPayNow),
                    child: const ItemVolunteeringProgramsWidget(widthImage: true),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(image: AssetImage(AppImages.backgroundDownloadAndApply), fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Text(
                  'Volunteering conditions',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  "Before you submit your volunteering application below, make sure you read TUA's volunteering conditions!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xffF9F9F9)),
                ),
                const SizedBox(height: 16),
                CustomTextButton(onPress: () {}, childText: 'download', backgroundColor: AppColors.white, colorText: AppColors.cP50),
                const SizedBox(height: 16),
                CustomTextButton(
                  onPress: () {},
                  childText: 'apply_now',
                  backgroundColor: AppColors.primaryColor,
                  borderColor: Colors.transparent,
                  colorText: AppColors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

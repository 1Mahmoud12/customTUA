import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/home/data/model/slider_model.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/view_all_volunteering_programs_view.dart';

class VolunteeringHeaderWidget extends StatelessWidget {
  final List<SliderData> firstSection;

  const VolunteeringHeaderWidget({
    super.key,
    required this.firstSection,
  });

  String _stripHtml(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final hasData = firstSection.isNotEmpty;
    final firstItem = hasData ? firstSection.first : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          // Main Title
          Text(
            firstItem?.title ?? 'About Volunteering',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.cP50,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),
          // Main Image
          CacheImage(
            height: 200,
            width: double.infinity,
            urlImage: firstItem?.image ?? '',
            fit: BoxFit.cover,
            borderRadius: 10,
          ),
          const SizedBox(height: 30),
          // Secondary Title
          Text(
            firstItem?.secondTitle ?? 'Volunteer ... Be The Change',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          // Content Description
          Text(
            _stripHtml(firstItem?.content ??
                "Stemming from Tkiyet Um Ali's belief in the importance..."),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.cP50,
            ),
          ),
          const SizedBox(height: 16),
          // See All Link
          SeeAllWidget(
            padding: EdgeInsets.zero,
            title: 'volunteering_programs',
            textStyle: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.w400),
            onTap: () {
              context.navigateToPage(
                const ViewAllVolunteeringProgramsView(),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
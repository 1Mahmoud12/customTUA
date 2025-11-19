import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:tua/feature/donations/data/models/donation_program_details_model.dart';

import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/app_icons.dart';

class DonationTabsSection extends StatelessWidget {
  final List<DonationTabModel>? tabs;

  const DonationTabsSection({super.key, required this.tabs});

  String stripHtml(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    if (tabs == null) return const SizedBox();

    return Column(
      children: [
        TabBar(
          labelStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w500),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: AppColors.cP50,
          unselectedLabelStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.cP50.withOpacity(.5)),
          tabs: tabs!.map((e) => Tab(text: e.title)).toList(),
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            children: tabs!.map((tab) {
              if (tab.labelUrl != null && tab.labelUrl!.isNotEmpty) {
                return Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tab.title,
                        style: Theme.of(
                          context,
                        ).textTheme.displayMedium?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(52),
                          border: Border.all(color: AppColors.cP100, width: 2),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'download_report'.tr(),
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50),
                            ),
                            const SizedBox(width: 8),
                            SvgPicture.asset(AppIcons.downloadIc),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Otherwise, show the tab description text
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  stripHtml(tab.brief ?? ''),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

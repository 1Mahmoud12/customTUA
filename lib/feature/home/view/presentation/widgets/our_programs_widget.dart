import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/common/data/dataSource/program_tag_data_source.dart';
import 'package:tua/feature/common/data/models/program_tag_model.dart';
import 'package:tua/feature/programs/view/presentation/feeding_programs_view.dart';
import 'package:tua/feature/programs/view/presentation/humanitarian_aid_programs_view.dart';
import 'package:tua/feature/programs/view/presentation/incidents_programs_view.dart';
import 'package:tua/feature/programs/view/presentation/ramadan_campaign_programs_view.dart';

class OurProgramsWidget extends StatefulWidget {
  const OurProgramsWidget({super.key});

  @override
  State<OurProgramsWidget> createState() => _OurProgramsWidgetState();
}

class _OurProgramsWidgetState extends State<OurProgramsWidget> {
  List<ProgramTagModel> _programTags = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgramTags();
  }

  Future<void> _loadProgramTags() async {
    // Check cache first
    if (ConstantsModels.programTagModel != null && ConstantsModels.programTagModel!.data.isNotEmpty) {
      setState(() {
        _programTags = ConstantsModels.programTagModel!.data;
        _isLoading = false;
      });
      return;
    }

    // Fetch from API
    final result = await ProgramTagDataSource.fetchProgramTags();
    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
        });
      },
      (response) {
        ConstantsModels.programTagModel = response;
        setState(() {
          _programTags = response.data;
          _isLoading = false;
        });
      },
    );
  }

  void _navigateToProgram(String title) {
    // Map titles to existing views
    final titleLower = title.toLowerCase();
    if (titleLower.contains('incident') || titleLower.contains('طارئ')) {
      context.navigateToPage(const IncidentsProgramsView());
    } else if (titleLower.contains('feeding') || titleLower.contains('غذائ')) {
      context.navigateToPage(const FeedingProgramsView());
    } else if (titleLower.contains('humanitarian') || titleLower.contains('إغاث')) {
      context.navigateToPage(const HumanitarianAidView());
    } else if (titleLower.contains('ramadan') || titleLower.contains('رمضان') || titleLower.contains('موسم')) {
      context.navigateToPage(const RamadanCampaignProgramsView());
    } else {
      // Default to feeding for unknown tags
      context.navigateToPage(const FeedingProgramsView());
    }
  }

  Color _parseColor(String colorHex) {
    try {
      return Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
    } catch (e) {
      return AppColors.cP50;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_programTags.isEmpty) {
      // Fallback to hardcoded items if API fails
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('our_programs'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            Row(
              children: [
                ItemProgramWidget(
                  nameItem: 'Incidents',
                  nameImage: AppIcons.incidentsIc,
                  colorItem: AppColors.cIncidentColor.withAlpha((.1 * 255).toInt()),
                  onTap: () {
                    context.navigateToPage(const IncidentsProgramsView());
                  },
                ),
                const SizedBox(width: 8),
                ItemProgramWidget(
                  nameItem: 'Feeding',
                  nameImage: AppIcons.feedingIc,
                  colorItem: AppColors.cFeedingColor.withAlpha((.1 * 255).toInt()),
                  onTap: () {
                    context.navigateToPage(const FeedingProgramsView());
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ItemProgramWidget(
                  nameItem: 'Humanitarian aid',
                  nameImage: AppIcons.humanitarianAidIc,
                  colorItem: AppColors.cHumanitarianAidColor.withAlpha((.1 * 255).toInt()),
                  onTap: () {
                    context.navigateToPage(const HumanitarianAidView());
                  },
                ),
                const SizedBox(width: 8),
                ItemProgramWidget(
                  nameItem: 'Ramadan campaigns',
                  nameImage: AppIcons.ramadanCampaignsIc,
                  colorItem: AppColors.cRamadanCampaignsColor.withAlpha((.1 * 255).toInt()),
                  onTap: () {
                    context.navigateToPage(const RamadanCampaignProgramsView());
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    // Display API tags (limit to 4 for 2x2 grid)
    final displayTags = _programTags.take(4).toList();
    final rows = <List<ProgramTagModel>>[];
    for (int i = 0; i < displayTags.length; i += 2) {
      rows.add(displayTags.skip(i).take(2).toList());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('our_programs'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          ...rows.map((row) => Padding(
                padding: EdgeInsets.only(bottom: row == rows.last ? 0 : 8),
                child: Row(
                  children: [
                    ...row.map((tag) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: row.indexOf(tag) == 0 ? 8 : 0),
                            child: ItemProgramWidget(
                              nameItem: tag.title,
                              nameImage: tag.tagIcon,
                              colorItem: _parseColor(tag.color).withAlpha((.1 * 255).toInt()),
                              isUrl: true,
                              onTap: () => _navigateToProgram(tag.title),
                            ),
                          ),
                        )),
                    // Fill empty space if odd number of items
                    if (row.length == 1) const Spacer(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class ItemProgramWidget extends StatelessWidget {
  const ItemProgramWidget({
    super.key,
    required this.nameItem,
    required this.nameImage,
    required this.colorItem,
    this.onTap,
    this.isUrl = false,
  });

  final String nameItem;
  final String nameImage;
  final Color colorItem;
  final VoidCallback? onTap;
  final bool isUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(56), color: colorItem),
            child: isUrl
                ? CacheImage(
                    urlImage: nameImage,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  )
                : SvgPicture.asset(nameImage),
          ),
          const SizedBox(height: 10),
          Text(
            nameItem,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/feature/common/data/dataSource/program_tag_data_source.dart';
import 'package:tua/feature/common/data/models/program_tag_model.dart';

class FiltersWidget extends StatefulWidget {
  final int selectedFilter;
  final Function(int)? onTap;

  const FiltersWidget({super.key, required this.selectedFilter, this.onTap});

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  List<ProgramTagModel> _programTags = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgramTags();
  }
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
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

  Future<void> _loadProgramTags() async {
    // Check cache first
    if (ConstantsModels.programTagModel != null &&
        ConstantsModels.programTagModel!.data.isNotEmpty) {
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 40,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // Show "All" filter first, then API tags
    final filters = <Widget>[
      ItemFilterWidget(
        title: 'all',
        isSelected: widget.selectedFilter == 0,
        onTap: () => widget.onTap?.call(0),
      ),
    ];

    // Add API tags starting from index 1
    for (int i = 0; i < _programTags.length; i++) {
      filters.add(
        ItemFilterWidget(
          nameImage: _programTags[i].tagIcon,
          title: _programTags[i].title,
          isSelected: widget.selectedFilter == i + 1,
          isUrl: true,
          onTap: () => widget.onTap?.call(i + 1),
        ),
      );
    }

    // Fallback to hardcoded filters if API fails
    if (_programTags.isEmpty) {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          ItemFilterWidget(
            title: 'all',
            isSelected: widget.selectedFilter == 0,
            onTap: () => widget.onTap?.call(0),
          ),
          ItemFilterWidget(
            nameImage: AppIcons.feedingIc,
            title: 'feeding',
            isSelected: widget.selectedFilter == 1,
            onTap: () => widget.onTap?.call(1),
          ),
          ItemFilterWidget(
            nameImage: AppIcons.incidentsIc,
            title: 'incidents',
            isSelected: widget.selectedFilter == 2,
            onTap: () => widget.onTap?.call(2),
          ),
          ItemFilterWidget(
            nameImage: AppIcons.volunteeringIc,
            title: 'volunteering',
            isSelected: widget.selectedFilter == 3,
            onTap: () => widget.onTap?.call(3),
          ),
          ItemFilterWidget(
            nameImage: AppIcons.humanitarianAidIc,
            title: 'humanitarian_aid',
            isSelected: widget.selectedFilter == 4,
            onTap: () => widget.onTap?.call(4),
          ),
        ],
      );
    }

    return Wrap(spacing: 10, runSpacing: 10, children: filters);
  }
}

class ItemFilterWidget extends StatelessWidget {
  final String? nameImage;
  final Function? onTap;
  final String title;
  final bool isSelected;
  final bool isUrl;

  const ItemFilterWidget({
    super.key,
    this.nameImage,
    required this.title,
    this.isSelected = false,
    this.onTap,
    this.isUrl = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cBorderButtonColor),
          color: isSelected ? AppColors.primaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (nameImage != null)
              isUrl
                  ? CacheImage(
                    urlImage: nameImage!,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  )
                  : SvgPicture.asset(
                    nameImage!,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isSelected ? AppColors.white : AppColors.greyG500,
                      BlendMode.srcIn,
                    ),
                  ),
            if (nameImage != null) const SizedBox(width: 8),
            Text(
              isUrl ? title : title.tr(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: isSelected ? AppColors.white : AppColors.greyG500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

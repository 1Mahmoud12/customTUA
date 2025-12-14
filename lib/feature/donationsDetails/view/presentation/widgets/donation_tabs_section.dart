import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/feature/donations/data/models/donation_program_details_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/app_icons.dart';

class DonationTabsSection extends StatefulWidget {
  final List<DonationTabModel>? tabs;

  const DonationTabsSection({super.key, required this.tabs});

  @override
  State<DonationTabsSection> createState() => _DonationTabsSectionState();
}

class _DonationTabsSectionState extends State<DonationTabsSection> {
  final Map<int, bool> _expandedStates = {};
  final Map<int, bool> _needsExpansion = {}; // 👈 جديد: لتتبع النصوص الطويلة
  int _currentTabIndex = 0;

  String stripHtml(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }

  bool isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        uri.hasAbsolutePath &&
        (uri.isScheme('http') || uri.isScheme('https'));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabs == null || widget.tabs!.isEmpty) return const SizedBox();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          onTap: (index) {
            setState(() {
              _currentTabIndex = index;
            });
          },
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
          tabs: widget.tabs!.map((e) => Tab(text: e.title)).toList(),
        ),
        const SizedBox(height: 16),
        ...widget.tabs!.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;

          if (index != _currentTabIndex) return const SizedBox.shrink();

          return _buildTabContent(tab, index);
        }).toList(),
      ],
    );
  }

  Widget _buildTabContent(DonationTabModel tab, int index) {
    if (tab.labelUrl != null && tab.labelUrl!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tab.title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppColors.cP50,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final url = tab.labelUrl?.trim() ?? '';
              if (!isValidUrl(url)) {
                customShowToast(
                  context,
                  'invalid_download_url'.tr(),
                  showToastStatus: ShowToastStatus.error,
                );
                return;
              }

              final fullUrl = url.startsWith('http') ? url : 'https://$url';

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(child: CircularProgressIndicator()),
              );

              if (await canLaunchUrl(Uri.parse(fullUrl))) {
                Navigator.of(context).pop();
                await launchUrl(
                  Uri.parse(fullUrl),
                  mode: LaunchMode.externalApplication,
                );
                return;
              }

              await _downloadAndOpen(context, fullUrl, tab.title);
            },
            child: Container(
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
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: AppColors.cP50),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(AppIcons.downloadIc),
                ],
              ),
            ),
          ),
        ],
      );
    }

    // For text content with see more/less
    final text = stripHtml(tab.brief ?? '');
    final isExpanded = _expandedStates[index] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // 👉 قياس النص لمعرفة إذا كان يتجاوز 5 أسطر
            final textPainter = TextPainter(
              text: TextSpan(
                text: text,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColors.cP50),
              ),
              maxLines: 5,
              textDirection:   Directionality.of(context),
            )..layout(maxWidth: constraints.maxWidth);

            final exceedsMaxLines = textPainter.didExceedMaxLines;

            // 👉 تخزين النتيجة
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_needsExpansion[index] != exceedsMaxLines) {
                setState(() {
                  _needsExpansion[index] = exceedsMaxLines;
                });
              }
            });

            return AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColors.cP50),
                maxLines: isExpanded ? null : 5,
                overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
            );
          },
        ),

        // 👉 اعرض الزر فقط إذا كان النص فعلياً أطول من 5 أسطر
        if (_needsExpansion[index] == true) ...[
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              setState(() {
                _expandedStates[index] = !isExpanded;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isExpanded ? 'see_less'.tr() : 'see_more'.tr(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.cP50,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.cP50,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _downloadAndOpen(
      BuildContext context, String url, String item) async {
    try {
      final dio = Dio();
      final directory = await getTemporaryDirectory();
      final fileName = item.split('/').last;
      final filePath = '${directory.path}/$fileName';

      await dio.download(url, filePath);
      Navigator.of(context).pop();

      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        customShowToast(context, 'Could not open file: ${result.message}');
      }
    } catch (e) {
      Navigator.of(context).pop();
      customShowToast(context, 'Failed to download file: $e');
    }
  }
}
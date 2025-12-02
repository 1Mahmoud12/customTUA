import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/search_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/campagin/view/presentation/create_campaign_view.dart';
import 'package:tua/feature/donations/view/presentation/widget/filter_widget.dart';
import 'package:tua/feature/home/view/presentation/widgets/donation_pregress_widget.dart';

class DonationsView extends StatefulWidget {
  const DonationsView({super.key});

  @override
  State<DonationsView> createState() => _DonationsViewState();
}

class _DonationsViewState extends State<DonationsView> {
  String? _selectedTag;
  String _searchQuery = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        leadingWidth: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.cP50, width: 2),
                borderRadius: BorderRadius.circular(100),
              ),
              child: InkWell(
                onTap: () {
                  // if (userCacheValue == null) {
                  //   loginRequiredDialog(context);
                  //   return;
                  // }
                  context.navigateToPage(const CreateCampaignView());
                },
                child: Text(
                  'create_campaign'.tr(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
        title: Text(
          'donations'.tr(),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
             Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: SearchWidget(
               onChange: (value) {
                 setState(() {
                   _selectedTag = null;
                   _searchQuery = value;
                 });
               },
             )),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FiltersWidget(
                selectedTag: _selectedTag,
                onTapTag: (tag) {
                  setState(() {
                    _selectedTag = tag; // null means "all"
                  });
                },
              ),
            ),
            const SizedBox(height: 26),
            DonationsProgressWidget(filterTag: _selectedTag, searchQuery: _searchQuery),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/divider.dart';
import 'package:tua/core/component/search_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/campagin/view/presentation/create_campaign_view.dart';
import 'package:tua/feature/donations/view/presentation/widget/custom_donation_widget.dart';
import 'package:tua/feature/donations/view/presentation/widget/feeding_widget.dart' show FeedingWidget;
import 'package:tua/feature/donations/view/presentation/widget/filter_widget.dart';
import 'package:tua/feature/donations/view/presentation/widget/humanitarian_aid_widget.dart' show HumanitarianAidWidget;
import 'package:tua/feature/home/view/presentation/widgets/donation_pregress_widget.dart';

class DonationsView extends StatefulWidget {
  const DonationsView({super.key});

  @override
  State<DonationsView> createState() => _DonationsViewState();
}

class _DonationsViewState extends State<DonationsView> {
  int _selectedFilter = 0;

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
              decoration: BoxDecoration(border: Border.all(color: AppColors.cP50, width: 2), borderRadius: BorderRadius.circular(100)),
              child: InkWell(
                onTap: () {
                  context.navigateToPage(const CreateCampaignView());
                },
                child: Text('create_campaign'.tr(), style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ],
        title: Text('donations'.tr(), style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400)),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 16),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: SearchWidget()),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FiltersWidget(
              selectedFilter: _selectedFilter,
              onTap: (p0) {
                setState(() {
                  _selectedFilter = p0;
                });
              },
            ),
          ),
          const SizedBox(height: 26),
          const DonationsProgressWidget(),
          const SizedBox(height: 26),
          const CustomDivider(),
          const SizedBox(height: 26),
          DonationsWidget(
            donations: [
              DonationModel(
                title: 'title',
                description: 'description',
                imagePath: '',
                raised: 0,
                goal: 0,
                nameDonation: 'donation',
                colorDonation: AppColors.cRed900,
              ),
              DonationModel(
                title: 'title',
                description: 'description',
                imagePath: '',
                raised: 0,
                goal: 0,
                nameDonation: 'donation',
                colorDonation: AppColors.cRed900,
              ),
            ],
            nameTittle: 'donation',
          ),
          const SizedBox(height: 26),
          const CustomDivider(),
          const SizedBox(height: 26),
          const FeedingWidget(),
          const SizedBox(height: 26),
          const HumanitarianAidWidget(),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}

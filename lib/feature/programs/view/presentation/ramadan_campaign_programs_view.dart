import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/search_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/programs/view/presentation/widgets/item_program_widget.dart';

class RamadanCampaignProgramsView extends StatelessWidget {
  const RamadanCampaignProgramsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'ramadan_campaign_programs'),
      body: ListView(
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: SearchWidget(onChange: (value) {})),
          ItemProgramWidget(
            color: AppColors.cRamadanCampaignsColor,
            raised: false,
            iconProgram: AppIcons.ramadanCampaignsIc,
            nameProgram: 'ramadan_campaigns',
          ),
          ItemProgramWidget(
            color: AppColors.cRamadanCampaignsColor,
            raised: false,
            iconProgram: AppIcons.ramadanCampaignsIc,
            nameProgram: 'ramadan_campaigns',
          ),
          ItemProgramWidget(
            color: AppColors.cRamadanCampaignsColor,
            raised: false,
            iconProgram: AppIcons.ramadanCampaignsIc,
            nameProgram: 'ramadan_campaigns',
          ),
          ItemProgramWidget(
            color: AppColors.cRamadanCampaignsColor,
            raised: false,
            iconProgram: AppIcons.ramadanCampaignsIc,
            nameProgram: 'ramadan_campaigns',
          ),
        ].paddingDirectional(top: 16),
      ),
    );
  }
}

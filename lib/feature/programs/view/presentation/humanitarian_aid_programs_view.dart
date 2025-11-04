import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/search_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/programs/view/presentation/widgets/item_program_widget.dart';

class HumanitarianAidView extends StatelessWidget {
  const HumanitarianAidView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'humanitarian_aid_programs'),
      body: ListView(
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: SearchWidget(onChange: (value) {})),
          ItemProgramWidget(
            color: AppColors.cHumanitarianAidColor,
            raised: false,
            iconProgram: AppIcons.humanitarianAidIc,
            nameProgram: 'humanitarian_aid',
          ),
          ItemProgramWidget(
            color: AppColors.cHumanitarianAidColor,
            raised: false,
            iconProgram: AppIcons.humanitarianAidIc,
            nameProgram: 'humanitarian_aid',
          ),
          ItemProgramWidget(
            color: AppColors.cHumanitarianAidColor,
            raised: false,
            iconProgram: AppIcons.humanitarianAidIc,
            nameProgram: 'humanitarian_aid',
          ),
        ].paddingDirectional(top: 16),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/search_widget.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/widgets/item_volunteeing_program_widget.dart';

class ViewAllVolunteeringProgramsView extends StatelessWidget {
  const ViewAllVolunteeringProgramsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'volunteering_programs'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SearchWidget(onChange: (value) {}),
          ...List.generate(5, (index) => const ItemVolunteeringProgramsWidget()),
        ].paddingDirectional(top: 16),
      ),
    );
  }
}

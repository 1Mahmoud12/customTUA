import 'package:flutter/material.dart';
import 'package:tua/feature/volunteeringPrograms/data/models/volunteering_program_model.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/widgets/item_volunteeing_program_widget.dart';

class VolunteeringProgramsListWidget extends StatelessWidget {
  final List<VolunteeringProgramModel> programs;

  const VolunteeringProgramsListWidget({
    super.key,
    required this.programs,
  });

  @override
  Widget build(BuildContext context) {
    if (programs.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: programs.map((program) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: ItemVolunteeringProgramsWidget(
              widthImage: true,
              program: program,
            ),
          );
        }).toList(),
      ),
    );
  }
}
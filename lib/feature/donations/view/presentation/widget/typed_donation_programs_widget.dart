import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/donations/data/models/donation_program_model.dart';
import 'package:tua/feature/donations/view/manager/donation_programs_cubit.dart';
import 'package:tua/feature/home/view/presentation/widgets/quick_donation_widget.dart';

import '../../../../programs/view/presentation/programs_by_tag_view.dart';

class TypedDonationProgramsWidget extends StatelessWidget {
  final String type; // The tag/type to filter by (e.g., "Feeding", "Humanitarian Aid")
  final String title; // The title to display (e.g., "feeding", "humanitarian_aid")

  const TypedDonationProgramsWidget({super.key, required this.type, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DonationProgramsCubit, DonationProgramsState>(
      listener: (context, state) {
        if (state is DonationProgramsError) {
          customShowToast(context, state.message, showToastStatus: ShowToastStatus.error);
        }
      },
      builder: (context, state) {
        List<DonationProgramModel> allPrograms = [];

        if (state is DonationProgramsLoaded) {
          allPrograms = state.programs;
        }

        // ✅ Filter programs by type/tag with trim() to handle extra spaces
        final filteredPrograms = allPrograms.where((program) =>
        program.tag.trim().toLowerCase() == type.trim().toLowerCase()
        ).toList();

        // Don't show widget if no programs match the type
        if (filteredPrograms.isEmpty && state is! DonationProgramsLoading) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            const SizedBox(height: 16),
            SeeAllWidget(
              title: title,
              showSeeAll: filteredPrograms.length > 3,
              onTap: () {
                context.navigateToPage(ProgramsByTagView(tag: type, title: title));
              },
            ),
            const SizedBox(height: 16),
            // ⏳ Loading
            if (state is DonationProgramsLoading && allPrograms.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: LoadingWidget(),
              )
            // ✅ Loaded — show filtered donation programs
            else if (filteredPrograms.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 8),
                    ...filteredPrograms.take(3).map((program) => ItemDonationsWidget(donation: program)),
                    const SizedBox(width: 16),
                  ],
                ),
              )
          ],
        );
      },
    );
  }
}
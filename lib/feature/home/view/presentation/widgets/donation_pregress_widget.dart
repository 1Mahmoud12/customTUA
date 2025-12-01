import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/divider.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/feature/donations/data/models/donation_program_model.dart';
import 'package:tua/feature/donations/view/manager/donation_programs_cubit.dart';
import 'package:tua/feature/donations/view/presentation/widget/item_donate_progress_widget.dart';
import 'package:tua/feature/donations/view/presentation/widget/typed_donation_programs_widget.dart';

import '../../../../../core/component/loadsErros/loading_widget.dart';
import '../../../../../core/utils/custom_show_toast.dart';

class DonationsProgressWidget extends StatelessWidget {
  const DonationsProgressWidget({super.key, this.filterTag, this.searchQuery});
  final String? filterTag; // null = all
  final String? searchQuery;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DonationProgramsCubit, DonationProgramsState>(
      listener: (context, state) {
        if (state is DonationProgramsError) {
          customShowToast(context, state.message, showToastStatus: ShowToastStatus.error);
        }
      },
      builder: (context, state) {
        List<DonationProgramModel> filteredPrograms = [];
        List<DonationProgramModel> allPrograms = [];
        final List<String> types = [];

        if (state is DonationProgramsLoaded) {
          allPrograms = state.programs;

          filteredPrograms = state.programs;

          if (filterTag != null && filterTag != 'all') {
            filteredPrograms = filteredPrograms
                .where((e) =>
            e.tag.toLowerCase().trim() ==
                filterTag!.toLowerCase().trim())
                .toList();
          }

          if (searchQuery != null && searchQuery!.isNotEmpty) {
            final query = searchQuery!.toLowerCase().trim();
            filteredPrograms = filteredPrograms.where((program) {
              final name = program.title?.toLowerCase() ?? '';

              final tag = program.tag.toLowerCase();

              return name.contains(query) ||
                  tag.contains(query);
            }).toList();
          }

          types.clear();
          for (final element in allPrograms) {
            if (!types.contains(element.tag)) {
              types.add(element.tag);
            }
          }
        }

        // ⏳ Loading
        if (state is DonationProgramsLoading && allPrograms.isEmpty) {
          return const Padding(padding: EdgeInsets.symmetric(vertical: 200), child: LoadingWidget());
        }

        // ❌ Error
        if (state is DonationProgramsError && allPrograms.isEmpty) {
          return Container();
        }

        // 💤 Empty
        if (allPrograms.isEmpty) {
          return Container();
        }

        // ✅ Loaded — show donation programs
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SeeAllWidget(
                title: 'donation_progress'.tr(),
                padding: EdgeInsets.zero,
                showSeeAll: false,
              ),
              const SizedBox(height: 8),
              if (filteredPrograms.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      // Icon(
                      //   Icons.search_off,
                      //   size: 64,
                      //   color: Colors.grey[400],
                      // ),
                      // const SizedBox(height: 16),
                      Text(
                        'no_programs_found'.tr()
                            ,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredPrograms.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final program = filteredPrograms[index];
                    return ItemDonateProgressWidget(donation: program);
                  },
                ),
              const SizedBox(height: 26),
              const CustomDivider(),
              const SizedBox(height: 26),
              for (final type in types) Column(
                children: [
                  TypedDonationProgramsWidget(type: type, title: type),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/divider.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/utils/errorLoadingWidgets/empty_widget.dart';
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
                .where((e) => e.tag.toLowerCase().trim() == filterTag!.toLowerCase().trim())
                .toList();
          }

          if (searchQuery != null && searchQuery!.isNotEmpty) {
            final query = searchQuery!.toLowerCase().trim();
            filteredPrograms = filteredPrograms.where((program) {
              final name = program.title.toLowerCase();
              final tag = program.tag.toLowerCase();
              return name.contains(query) || tag.contains(query);
            }).toList();
          }

          // ✅ Fix: استخدم Set لإزالة التكرارات تلقائياً
          // وقارن الـ tags بعد trim و toLowerCase
          final Set<String> uniqueTags = {};

          for (final element in allPrograms) {
            final cleanTag = element.tag.trim();
            // استخدم lowercase للمقارنة لكن احفظ النسخة الأصلية
            final lowerTag = cleanTag.toLowerCase();

            // لو الـ tag مش موجود، ضيفه
            if (!uniqueTags.any((tag) => tag.toLowerCase() == lowerTag)) {
              uniqueTags.add(cleanTag);
            }
          }

          types.clear();
          types.addAll(uniqueTags);
        }

        // ⏳ Loading
        if (state is DonationProgramsLoading && allPrograms.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 200),
            child: LoadingWidget(),
          );
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeeAllWidget(
                title: 'donation_progress'.tr(),
                padding: EdgeInsets.zero,
                showSeeAll: false,
              ),
              const SizedBox(height: 8),
              if (filteredPrograms.isEmpty)
                EmptyWidget(
                  emptyImage: EmptyImages.noDonationsHistoryIc,
                  data: 'no_programs_found'.tr(),
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
              for (final type in types)
                Column(
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
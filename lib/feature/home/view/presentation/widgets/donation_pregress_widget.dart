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
  const DonationsProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DonationProgramsCubit, DonationProgramsState>(
      listener: (context, state) {
        if (state is DonationProgramsError) {
          customShowToast(context, state.message, showToastStatus: ShowToastStatus.error);
        }
      },
      builder: (context, state) {
        List<DonationProgramModel> programs = [];
        final List<String> types = [];
        if (state is DonationProgramsLoaded) {
          programs = state.programs;
          types.clear();
          for (final element in programs) {
            if (!types.contains(element.tag)) {
              types.add(element.tag);
            }
          }
        }

        // ⏳ Loading
        if (state is DonationProgramsLoading && programs.isEmpty) {
          return const Padding(padding: EdgeInsets.symmetric(vertical: 200), child: LoadingWidget());
        }

        // ❌ Error
        if (state is DonationProgramsError && programs.isEmpty) {
          return Container();
        }

        // 💤 Empty
        if (programs.isEmpty) {
          return Container();
        }

        // ✅ Loaded — show donation programs
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SeeAllWidget(title: 'donation_progress'.tr(), padding: EdgeInsets.zero, showSeeAll: false),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: programs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final program = programs[index];
                  return ItemDonateProgressWidget(donation: program);
                },
              ),
              const SizedBox(height: 26),
              const CustomDivider(),
              const SizedBox(height: 26),
              for (final type in types) Column(
                children: [
                  // SizedBox(height: 25,),
                  TypedDonationProgramsWidget(type: type, title: type),
                // SizedBox(height: 100,)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

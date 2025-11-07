import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tua/core/component/empty_widget.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/themes/styles.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/donations/data/data_source/donation_programs_data_source.dart';
import 'package:tua/feature/donations/view/manager/donation_programs_cubit.dart';
import 'package:tua/feature/donations/view/presentation/widget/item_donate_progress_widget.dart';
import 'package:tua/feature/donationsDetails/view/presentation/donation_details_view.dart';

import '../../../../../core/component/loadsErros/loading_widget.dart';
import '../../../../../core/utils/cusotm_container.dart';
import '../../../../../core/utils/custom_show_toast.dart';
import '../../../../../core/utils/errorLoadingWidgets/empty_widget.dart';

class DonationsProgressWidget extends StatelessWidget {
  const DonationsProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DonationProgramsCubit(DonationProgramsDataSource())..fetchDonationPrograms(),
      child: BlocConsumer<DonationProgramsCubit, DonationProgramsState>(
        listener: (context, state) {
          if (state is DonationProgramsError) {
            customShowToast(context, state.message, showToastStatus: ShowToastStatus.error);
          }
        },
        builder: (context, state) {
          final cubit = context.read<DonationProgramsCubit>();
          List programs = [];

          if (state is DonationProgramsLoaded) {
            programs = state.programs;
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
                SeeAllWidget(
                  title: 'donation_progress'.tr(),
                  padding: EdgeInsets.zero,
                  showSeeAll: false,
                ),
                const SizedBox(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: programs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final program = programs[index];
                    return ItemDonateProgressWidget(donation: program);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

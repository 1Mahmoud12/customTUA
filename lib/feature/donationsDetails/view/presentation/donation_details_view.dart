import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/feature/donations/data/data_source/donation_programs_data_source.dart';
import 'package:tua/feature/donations/view/manager/donation_program_details_cubit.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/donation_details_view_body.dart';

import '../../../../core/utils/errorLoadingWidgets/empty_widget.dart';

class DonationDetailsView extends StatelessWidget {
  const DonationDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DonationProgramDetailsCubit(DonationProgramsDataSource())..fetchDonationProgramById(id),
      child: BlocConsumer<DonationProgramDetailsCubit, DonationProgramDetailsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: customAppBar(context: context, title: 'donation_details'),
            body:
                state is DonationProgramDetailsLoading
                    ? const Padding(padding: EdgeInsets.symmetric(vertical: 100.0), child: LoadingWidget())
                    : state is DonationProgramDetailsLoaded
                    ? DonationDetailsViewBody(detailsModel: state.program)
                    : state is DonationProgramDetailsError
                    ? EmptyWidget(data: state.message)
                    : const EmptyWidget(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/feature/home/data/homeDataSource/home_data_source.dart';
import 'package:tua/feature/volunteeringPrograms/data/data_source/volunteering_programs_data_source.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/widgets/volunteering_bottom_card_widget.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/widgets/volunteering_header_widget.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/widgets/volunteering_programs_list_widget.dart';

import '../manager/volunteering_programs_cubit.dart';

class VolunteeringProgramsView extends StatelessWidget {
  const VolunteeringProgramsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VolunteeringProgramsCubit(
        VolunteeringProgramsDataSource(),
        HomeDataSourceImpl(),
      )..loadAllData(),
      child: Scaffold(
        appBar: customAppBar(context: context, title: 'volunteering_programs'),
        body: BlocBuilder<VolunteeringProgramsCubit, VolunteeringProgramsState>(
          builder: (context, state) {
            if (state is VolunteeringProgramsLoading) {
              return const Center(child: LoadingWidget());
            }

            if (state is VolunteeringProgramsError) {
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }

            if (state is VolunteeringProgramsLoaded) {
              return RefreshIndicator(
                onRefresh: () => context.read<VolunteeringProgramsCubit>().refreshData(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      VolunteeringHeaderWidget(firstSection: state.firstSection),
                      VolunteeringProgramsListWidget(programs: state.programs),
                      const SizedBox(height: 16),
                      VolunteeringBottomCardWidget(thirdSection: state.thirdSection),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
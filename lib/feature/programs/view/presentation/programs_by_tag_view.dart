import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/component/search_widget.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/errorLoadingWidgets/empty_widget.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/donations/data/data_source/donation_programs_data_source.dart';
import 'package:tua/feature/donations/data/models/donation_program_model.dart';
import 'package:tua/feature/donations/view/manager/donation_programs_cubit.dart';
import 'package:tua/feature/home/view/presentation/widgets/quick_donation_widget.dart';

class ProgramsByTagView extends StatefulWidget {
  final String tag; // The tag to filter by
  final String title; // The title for the app bar

  const ProgramsByTagView({
    super.key,
    required this.tag,
    required this.title,
  });

  @override
  State<ProgramsByTagView> createState() => _ProgramsByTagViewState();
}

class _ProgramsByTagViewState extends State<ProgramsByTagView> {
  String _searchQuery = '';

  List<DonationProgramModel> _filterPrograms(List<DonationProgramModel> programs) {
    // First filter by tag
    final tagFiltered = programs.where(
          (program) =>
          program.tag.trim().toLowerCase().contains(widget.tag.trim().toLowerCase()),
    ).toList();
    // Then filter by search query if provided
    if (_searchQuery.isEmpty) {
      return tagFiltered;
    }
    final query = _searchQuery.toLowerCase();
    return tagFiltered.where((program) {
      return program.title.toLowerCase().contains(query) || program.tag.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DonationProgramsCubit(DonationProgramsDataSource())..fetchDonationPrograms( widget.tag),
      child: BlocConsumer<DonationProgramsCubit, DonationProgramsState>(
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

          final filteredPrograms = _filterPrograms(allPrograms);

          return Scaffold(
            appBar: customAppBar(context: context, title: widget.title),
            body: (state is DonationProgramsLoading && filteredPrograms.isEmpty)
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 100.0),
                    child: LoadingWidget(),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      SearchWidget(
                        onChange: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                      if (filteredPrograms.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50.0),
                          child: EmptyWidget(data: 'no_programs_found',),
                        )
                      else
                        ...filteredPrograms.map(
                          (program) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ItemDonationsWidget(donation: program),
                          ),
                        ),
                    ].paddingDirectional(top: 16),
                  ),
          );
        },
      ),
    );
  }
}


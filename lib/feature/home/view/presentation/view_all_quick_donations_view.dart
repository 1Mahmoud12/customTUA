import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/component/search_widget.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/donations/data/models/donation_program_model.dart';
import 'package:tua/feature/donations/view/manager/donation_programs_cubit.dart';
import 'package:tua/feature/home/view/presentation/widgets/quick_donation_widget.dart';

class ViewAllQuickDonationsView extends StatefulWidget {
  const ViewAllQuickDonationsView({super.key});

  @override
  State<ViewAllQuickDonationsView> createState() => _ViewAllQuickDonationsViewState();
}

class _ViewAllQuickDonationsViewState extends State<ViewAllQuickDonationsView> {
  String _searchQuery = '';

  List<DonationProgramModel> _filterPrograms(List<DonationProgramModel> programs) {
    if (_searchQuery.isEmpty) {
      return programs;
    }
    final query = _searchQuery.toLowerCase();
    return programs.where((program) {
      return program.title.toLowerCase().contains(query) || program.tag.toLowerCase().contains(query);
    }).toList();
  }

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

        if (state is DonationProgramsLoaded) {
          programs = state.programs;
        }

        final filteredPrograms = _filterPrograms(programs);

        return Scaffold(
          appBar: customAppBar(context: context, title: 'quick_donations'),
          body:
              (state is DonationProgramsLoading && programs.isEmpty)
                  ? const Padding(padding: EdgeInsets.symmetric(vertical: 100.0), child: LoadingWidget())
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
                          child: Center(
                            child: Text(
                              'no_donations_found'.tr(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        )
                      else
                        ...filteredPrograms.map(
                          (program) => ItemDonationsWidget(donation: program),
                        ),
                    ].paddingDirectional(top: 16),
                  ),
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/component/search_widget.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/volunteeringPrograms/data/data_source/volunteering_programs_data_source.dart';
import 'package:tua/feature/volunteeringPrograms/data/models/volunteering_program_model.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/widgets/item_volunteeing_program_widget.dart';

class ViewAllVolunteeringProgramsView extends StatefulWidget {
  const ViewAllVolunteeringProgramsView({super.key});

  @override
  State<ViewAllVolunteeringProgramsView> createState() =>
      _ViewAllVolunteeringProgramsViewState();
}

class _ViewAllVolunteeringProgramsViewState
    extends State<ViewAllVolunteeringProgramsView> {
  final VolunteeringProgramsDataSource _dataSource =
      VolunteeringProgramsDataSource();
  List<VolunteeringProgramModel> _programs = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadVolunteeringPrograms();
  }

  Future<void> _loadVolunteeringPrograms() async {
    final result = await _dataSource.getVolunteeringPrograms();
    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
        });
      },
      (response) {
        setState(() {
          _programs = response.data;
          _isLoading = false;
        });
      },
    );
  }

  List<VolunteeringProgramModel> get _filteredPrograms {
    if (_searchQuery.isEmpty) {
      return _programs;
    }
    final query = _searchQuery.toLowerCase();
    return _programs.where((program) {
      return program.title.toLowerCase().contains(query) ||
          program.brief.toLowerCase().contains(query) ||
          program.slug.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'volunteering_programs'),
      body:
          _isLoading
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
                  if (_filteredPrograms.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Center(
                        child: Text(
                          'no_volunteering_programs_found'.tr(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    )
                  else
                    ..._filteredPrograms.map(
                      (program) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ItemVolunteeringProgramsWidget(program: program),
                      ),
                    ),
                ].paddingDirectional(top: 16),
              ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/volunteeringPrograms/data/data_source/volunteering_programs_data_source.dart';
import 'package:tua/feature/volunteeringPrograms/data/models/volunteering_program_model.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/application_form_view.dart';

class DetailsVolunteeringView extends StatefulWidget {
  final int? programId;

  const DetailsVolunteeringView({super.key, this.programId});

  @override
  State<DetailsVolunteeringView> createState() => _DetailsVolunteeringViewState();
}

class _DetailsVolunteeringViewState extends State<DetailsVolunteeringView> {
  final VolunteeringProgramsDataSource _dataSource = VolunteeringProgramsDataSource();
  VolunteeringProgramModel? _program;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.programId != null) {
      _loadProgramDetails();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadProgramDetails() async {
    if (widget.programId == null) return;

    final result = await _dataSource.getVolunteeringProgramById(widget.programId!);
    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
        });
      },
      (program) {
        setState(() {
          _program = program;
          _isLoading = false;
        });
      },
    );
  }

  String _stripHtmlTags(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: _program?.title ?? 'name_volunteering_program'),
      body:
          _isLoading
              ? const Padding(padding: EdgeInsets.symmetric(vertical: 100.0), child: LoadingWidget())
              : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(),
                  CacheImage(
                    urlImage: _program?.image ?? '',
                    width: double.infinity,
                    height: context.screenHeight * .3,
                    fit: BoxFit.cover,
                    borderRadius: 10,
                  ),
                  Text('${'description'.tr()}: ', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400)),
                  Text(
                    _program != null
                        ? _stripHtmlTags(_program!.brief)
                        : "Packaging food parcels is a main volunteering program that offers volunteers the opportunity to participate in packaging Tkiyet Um Ali's monthly food parcels at its warehouses in AlQastal, allowing them to better understand the magnitude of operations inside the warehouses including packaging the food items inside the food parcels and their quantities, depending on the category of parcel.",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  if (_program?.fileLabel != null && _program!.fileLabel!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(_program!.fileLabel!, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400)),
                  ],
                  CustomTextButton(
                    onPress: () {
                      context.navigateToPage(ApplicationFormView(typeId: _program!.id));
                    },
                    childText: 'apply_now',
                  ),
                ].paddingDirectional(top: 16),
              ),
    );
  }
}

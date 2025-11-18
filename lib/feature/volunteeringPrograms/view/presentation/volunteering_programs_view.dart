import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/volunteeringPrograms/data/data_source/volunteering_programs_data_source.dart';
import 'package:tua/feature/volunteeringPrograms/data/models/volunteering_program_model.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/view_all_volunteering_programs_view.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/widgets/item_volunteeing_program_widget.dart';

class VolunteeringProgramsView extends StatefulWidget {
  const VolunteeringProgramsView({super.key});

  @override
  State<VolunteeringProgramsView> createState() => _VolunteeringProgramsViewState();
}

class _VolunteeringProgramsViewState extends State<VolunteeringProgramsView> {
  final VolunteeringProgramsDataSource _dataSource = VolunteeringProgramsDataSource();
  List<VolunteeringProgramModel> _programs = [];
  bool _isLoading = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'volunteering_programs'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  'About Volunteering',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 30),
                const CacheImage(height: 200, width: double.infinity, urlImage: '', fit: BoxFit.cover, borderRadius: 10),
                const SizedBox(height: 30),
                Text(
                  'Volunteer ... Be The Change',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400, color: AppColors.primaryColor),
                ),
                const SizedBox(height: 16),
                Text(
                  'Stemming from Tkiyet Um Ali’s belief in the  importance  of  spreading  awareness  about\nfood poverty, and with an aim  to  enhance  social  solidarity  that  plays  an  instrumental\nand influential part in achieving its goals, TKiyet Um Ali  welcomes  dedicated  volunteers\nstriving to help from all over the Kingdom.',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50),
                ),
                const SizedBox(height: 16),
                SeeAllWidget(
                  padding: EdgeInsets.zero,
                  title: 'volunteering_programs',
                  textStyle: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400),
                  onTap: () {
                    context.navigateToPage(const ViewAllVolunteeringProgramsView());
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          if (_isLoading)
            const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Center(child: LoadingWidget()))
          else if (_programs.isEmpty)
            const SizedBox.shrink()
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 8),
                  ..._programs.map(
                    (program) =>
                        Container(padding: const EdgeInsets.all(8), child: ItemVolunteeringProgramsWidget(widthImage: true, program: program)),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(image: AssetImage(AppImages.backgroundDownloadAndApply), fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Text(
                  'Volunteering conditions',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  "Before you submit your volunteering application below, make sure you read TUA's volunteering conditions!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xffF9F9F9)),
                ),
                const SizedBox(height: 16),
                CustomTextButton(onPress: () {}, childText: 'download', backgroundColor: AppColors.white, colorText: AppColors.cP50),
                const SizedBox(height: 16),
                CustomTextButton(
                  onPress: () {},
                  childText: 'apply_now',
                  backgroundColor: AppColors.primaryColor,
                  borderColor: Colors.transparent,
                  colorText: AppColors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

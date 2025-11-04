import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tua/core/component/divider.dart';
import 'package:tua/core/component/search_widget.dart' show SearchWidget;
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/home/view/manager/cubit.dart';
import 'package:tua/feature/home/view/presentation/widgets/donation_pregress_widget.dart' show DonationsProgressWidget;
import 'package:tua/feature/home/view/presentation/widgets/quick_donation_widget.dart' show QuickDonations;
import 'package:tua/feature/home/view/presentation/widgets/quick_tool_widget.dart' show QuickTools;
import 'package:tua/feature/home/view/presentation/widgets/slider_widget.dart';
import 'package:tua/feature/search/view/presentation/search_view.dart';

import 'widgets/header_widget.dart';
import 'widgets/our_programs_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeCubit homeCubit = HomeCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: ListView(
        children: [
          const HeaderWidget(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchWidget(
              hintText: 'Search campaign, charity,etc',
              onTap: () {
                context.navigateToPage(const SearchView());
              },
            ),
          ),
          const SizedBox(height: 16),
          SliderWidget(homeCubit: homeCubit),
          const SizedBox(height: 8),
          const OurProgramsWidget(),
          const SizedBox(height: 16),
          const CustomDivider(),
          const SizedBox(height: 16),
          const QuickDonations(),
          const SizedBox(height: 16),
          const CustomDivider(),
          const SizedBox(height: 16),
          const QuickTools(),
          const SizedBox(height: 16),
          const CustomDivider(),
          const SizedBox(height: 16),
          const DonationsProgressWidget(),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}

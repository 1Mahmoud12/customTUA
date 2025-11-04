import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tua/core/component/custom_load_switch_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/bottomSheet/log_out_dialog.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/donationHistory/view/presentation/donation_history_view.dart';
import 'package:tua/feature/menu/view/presentation/widgets/data_profile_widget.dart' show DataProfileWidget;
import 'package:tua/feature/menu/view/presentation/widgets/item_profile_widget.dart' show ItemProfileWidget;
import 'package:tua/feature/menu/view/presentation/widgets/selected_language_dialog.dart';
import 'package:tua/feature/myContribution/view/presentation/my_contributions_view.dart';
import 'package:tua/feature/secondaryUser/view/presentation/secondary_user_view.dart';
import 'package:tua/feature/sponsorship/view/presentation/sponsorship_view.dart';
import 'package:tua/feature/staticPages/view/presentation/contact_us_view.dart';
import 'package:tua/feature/staticPages/view/presentation/terms_conditions_view.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/volunteering_programs_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  bool notificationValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('menu'.tr(), style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400)),
        centerTitle: false,
        leadingWidth: 0,
        leading: const SizedBox(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 23),
          const DataProfileWidget(),

          ItemProfileWidget(
            name: 'volunteering_programs',
            image: AppIcons.donationHistoryIc,
            onTap: () {
              context.navigateToPage(const VolunteeringProgramsView(), pageTransitionType: PageTransitionType.rightToLeft);
            },
          ),
          ItemProfileWidget(
            name: 'notifications',
            image: AppIcons.notificationProfileIc,
            widget: CustomLoadSwitchWidget(
              label: '',
              initialValue: notificationValue,
              activeColor: AppColors.primaryColor,
              onChanged: ({required value}) {
                notificationValue = !notificationValue;
                setState(() {});
              },
              future: () async {
                return true;
              },
            ),
          ),
          ItemProfileWidget(
            name: 'language',
            image: AppIcons.languageIc,
            widget: Text(
              context.locale.languageCode == 'ar' ? 'العربيه' : 'English',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.greyG500, fontWeight: FontWeight.w400),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SelectLanguageDialog(selectedIndex: context.locale.languageCode == 'ar' ? 0 : 1);
                },
              );
            },
          ),
          ItemProfileWidget(
            name: 'sponsorship',
            image: AppIcons.sponsershipIc,
            onTap: () {
              context.navigateToPage(const SponsorshipView(), pageTransitionType: PageTransitionType.rightToLeft);
            },
          ),
          ItemProfileWidget(
            name: 'donation_history',
            image: AppIcons.donationHistoryIc,
            onTap: () {
              context.navigateToPage(const DonationHistoryView(), pageTransitionType: PageTransitionType.rightToLeft);
            },
          ),
          ItemProfileWidget(
            name: 'my_contributions',
            image: AppIcons.myContributionIc,
            onTap: () {
              context.navigateToPage(const MyContributionsView(), pageTransitionType: PageTransitionType.rightToLeft);
            },
          ),
          ItemProfileWidget(
            name: 'secondary_user',
            image: AppIcons.secondaryUserIc,
            onTap: () {
              context.navigateToPage(const SecondaryUserView(), pageTransitionType: PageTransitionType.rightToLeft);
            },
          ),
          ItemProfileWidget(
            name: 'about_the_application',
            image: AppIcons.aboutIc,

            onTap: () {
              context.navigateToPage(const ContactUsView(), pageTransitionType: PageTransitionType.rightToLeft);
            },
          ),
          ItemProfileWidget(
            name: 'terms_and_conditions',
            image: AppIcons.termsIc,
            onTap: () {
              context.navigateToPage(const TermsConditionsView(), pageTransitionType: PageTransitionType.rightToLeft);
            },
          ),
          ItemProfileWidget(
            name: 'logout',
            image: AppIcons.logoutIc,
            onTap: () {
              logOutDialog(context: context, onPress: () {});
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

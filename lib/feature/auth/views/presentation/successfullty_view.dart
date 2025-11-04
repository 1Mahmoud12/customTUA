import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';

class SuccessfullyView extends StatelessWidget {
  const SuccessfullyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'reset_password'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(AppIcons.forgetPasswordIc),
              Text('Successfully! 🎉'.tr(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
              Text(
                'your_password_has_been_replaced._try_to_login_to_explore_&_discover_the_application.'.tr(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.cP50),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 24),
              CustomTextButton(
                onPress: () {
                  context.navigateToPage(NavigationView());
                },
                childText: 'go_to_home'.tr(),
              ),
            ].paddingDirectional(top: 24),
          ),
        ),
      ),
    );
  }
}

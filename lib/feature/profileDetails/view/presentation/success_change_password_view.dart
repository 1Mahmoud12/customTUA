import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/utils/errorLoadingWidgets/empty_widget.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';
import 'package:tua/feature/profileDetails/view/presentation/profile_details_view.dart';

class SuccessChangePasswordView extends StatelessWidget {
  const SuccessChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.navigateToPage(const NavigationView(customIndex: 3));
        context.navigateToPage(const ProfileDetailsView());
      },
      child: Scaffold(
        appBar: customAppBar(context: context, title: 'change_password'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: EmptyWidget(
                  emptyImage: EmptyImages.changePassword,
                  data: 'password_changed_successfully',
                  subData: 'your_password_has_been_changed_successfully',
                ),
              ),
              const SizedBox(height: 130),
              CustomTextButton(
                onPress: () {
                  context.navigateToPage(const NavigationView());
                },
                childText: 'back_to_home_screen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

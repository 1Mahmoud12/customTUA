import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/utils/errorLoadingWidgets/empty_widget.dart';

class SuccessChangePasswordView extends StatelessWidget {
  const SuccessChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            CustomTextButton(onPress: () {}, childText: 'back_to_home_screen'),
          ],
        ),
      ),
    );
  }
}

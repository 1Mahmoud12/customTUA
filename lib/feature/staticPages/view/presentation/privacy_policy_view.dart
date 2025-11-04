import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/extensions.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'privacy_policy'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Text('1- What is Lorem Ipsum?', style: Theme.of(context).textTheme.displaySmall),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.",
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.cP50.withAlpha((.5 * 255).toInt())),
          ),
        ].paddingDirectional(top: 16),
      ),
    );
  }
}

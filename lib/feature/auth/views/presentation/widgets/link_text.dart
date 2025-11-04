import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/themes/colors.dart';

class LinkText extends StatelessWidget {
  final String mainText;
  final String linkText;
  final VoidCallback onLinkTap;

  const LinkText({super.key, required this.mainText, required this.linkText, required this.onLinkTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: mainText,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.greyG600),
        children: <TextSpan>[
          const TextSpan(text: '  \n '),
          TextSpan(
            text: linkText,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppColors.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryColor,
            ),

            recognizer: TapGestureRecognizer()..onTap = onLinkTap,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

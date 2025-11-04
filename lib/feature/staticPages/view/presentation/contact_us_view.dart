import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'contact_us'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'contact_details'.tr(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500, color: AppColors.primaryColor),
              ),
              Text('How can we help you?'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
              Text(
                'We’re here to help! If you have any questions, need assistance, or want more information, please feel free to reach out.'.tr(),
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.cP50.withAlpha((.5 * 255).toInt())),
              ),
            ].paddingDirectional(top: 8),
          ),
          const SizedBox(height: 24),
          ItemContactUsWidget(
            nameButton: 'call_now',
            nameImage: AppIcons.contactUsScreenIc,
            title: 'phone',
            valueTitle: '+962-64900900',
            isExpand: true,
            onPress: () {},
          ),
          ItemContactUsWidget(
            nameButton: 'send_email',
            paddingButton: EdgeInsets.symmetric(vertical: 18, horizontal: context.screenWidth * .2),

            nameImage: AppIcons.emailScreenIc,
            title: 'email',
            valueTitle: 'info@tua.jo',
            onPress: () {},
          ),
          ItemContactUsWidget(
            nameButton: 'get_direction',
            nameImage: AppIcons.locationScreenIc,
            title: 'location',
            valueTitle: 'Jordan, Amman, Al-Mahata,56Al-Jaish St.',
            onPress: () {},
          ),
        ],
      ),
    );
  }
}

class ItemContactUsWidget extends StatelessWidget {
  final String nameImage;
  final String title;
  final String valueTitle;
  final String nameButton;
  final EdgeInsets paddingButton;
  final bool isExpand;
  final Function onPress;

  const ItemContactUsWidget({
    super.key,
    required this.nameImage,
    required this.title,
    required this.valueTitle,
    required this.onPress,
    required this.nameButton,
    this.isExpand = false,
    this.paddingButton = const EdgeInsets.symmetric(vertical: 18, horizontal: 21),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cP50.withAlpha((0.2 * 255).toInt())),
        color: AppColors.cBackGroundButtonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SvgPicture.asset(nameImage),
          const SizedBox(height: 12),
          Text(title.tr(), style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.greyG600)),
          const SizedBox(height: 12),
          Text(
            valueTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.cP50),
          ),
          const SizedBox(height: 16),
          CustomTextButton(onPress: () {}, padding: paddingButton, childText: nameButton, isExpand: isExpand),
        ],
      ),
    );
  }
}

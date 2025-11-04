import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart' show PageTransitionType;
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/bottomSheet/delete_account_dialog.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/profileDetails/view/presentation/change_password_view.dart';

class ProfileDetailsView extends StatelessWidget {
  const ProfileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'profile_details'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 8),
          const ImageProfileWidget(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppIcons.smallInfoIc),
                  const SizedBox(width: 8),
                  Text('please_note'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Only the password can be modified. If this information is used to verify your identity, you will need to verify it again the next time you change your password. Tkiyet Um Ali does not publish any information about you.'
                    .tr(),
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(color: AppColors.cP50.withAlpha((.5 * 255).toInt()), fontWeight: FontWeight.w500),
              ),
            ],
          ),
          CustomTextFormField(controller: TextEditingController(), hintText: 'enter_your_name'.tr(), nameField: 'name'),
          CustomTextFormField(controller: TextEditingController(), hintText: 'enter_your_email'.tr(), nameField: 'email', enable: false),
          CustomTextFormField(controller: TextEditingController(), hintText: 'XX XXX XXX'.tr(), nameField: 'mobile_number'),
          CustomTextButton(
            onPress: () {
              context.navigateToPage(const ChangePasswordView(), pageTransitionType: PageTransitionType.rightToLeft);
            },
            childText: 'change_password'.tr(),
            colorText: AppColors.white,
            backgroundColor: AppColors.primaryColor,
            borderColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 17),
          ),
          CustomTextButton(
            onPress: () {},
            padding: const EdgeInsets.symmetric(vertical: 17),
            childText: 'save_changes'.tr(),
            colorText: AppColors.white,
            backgroundColor: AppColors.cP50,
            borderColor: Colors.transparent,
          ),
          InkWell(
            onTap: () {
              deleteAccountDialog(context: context, onPress: () {});
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(border: Border.all(color: AppColors.greyBorderColor), borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.deleteAccountIc),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'delete_account'.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.cError300, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ].paddingDirectional(bottom: 16),
      ),
    );
  }
}

class ImageProfileWidget extends StatelessWidget {
  const ImageProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          const Padding(padding: EdgeInsets.all(8.0), child: CacheImage(urlImage: '', profileImage: true, width: 100, height: 100, circle: true)),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor),
            child: SvgPicture.asset(AppIcons.editProfileIc, width: 15, height: 15),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart' show PageTransitionType;
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/bottomSheet/delete_account_dialog.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/profileDetails/data/data_source/profile_details_data_source.dart';
import 'package:tua/feature/profileDetails/data/data_source/profile_details_data_source_impl.dart';
import 'package:tua/feature/profileDetails/view/manager/update_profile_cubit/profile_update_cubit.dart';
import 'package:tua/feature/profileDetails/view/presentation/change_password_view.dart';

import '../../../sponsorship/view/presentation/widgets/phone_field_widget.dart';
import '../manager/update_profile_cubit/profile_update_state.dart';

class ProfileDetailsView extends StatelessWidget {
  const ProfileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileUpdateCubit(ProfileDetailsDataSourceImpl()),
      child: BlocConsumer<ProfileUpdateCubit, ProfileUpdateState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            customShowToast(context, 'profile_update_success'.tr());
          } else if (state is ProfileUpdateFailure) {
            customShowToast(context, state.message.tr(), showToastStatus: ShowToastStatus.error);
          }
        },
        builder: (context, state) {
          final cubit = context.read<ProfileUpdateCubit>();
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
                        Text(
                          'please_note'.tr(),
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Only the password can be modified. If this information is used to verify your identity, you will need to verify it again the next time you change your password. Tkiyet Um Ali does not publish any information about you.'
                          .tr(),
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.cP50.withAlpha((.5 * 255).toInt()),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                CustomTextFormField(
                  controller: cubit.firstNameController,
                  hintText: 'enter_first_name'.tr(),
                  nameField: 'first_name',
                ),
                CustomTextFormField(
                  controller: cubit.lastNameController,
                  hintText: 'enter_last_name'.tr(),
                  nameField: 'last_name',
                ),
                CustomTextFormField(
                  controller: TextEditingController(text: userCacheValue?.email??''),
                  hintText: 'enter_your_email'.tr(),
                  nameField: 'email',
                  enable: false,
                ),
                PhoneFieldWidget(
                  hintText: 'enter_your_phone'.tr(),
                  nameField: 'phone_number'.tr(),
                  initialValue: userCacheValue?.phone ?? '',

                  onChange: (p0) {
                    cubit.phoneController.text = p0;
                  },
                ),
                CustomTextButton(
                  onPress: () {
                    context.navigateToPage(
                      const ChangePasswordView(),
                      pageTransitionType: PageTransitionType.rightToLeft,
                    );
                  },
                  childText: 'change_password'.tr(),
                  colorText: AppColors.white,
                  backgroundColor: AppColors.primaryColor,
                  borderColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 17),
                ),
                CustomTextButton(
                  onPress: () {
                    cubit.updateProfile(context);
                  },
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
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyBorderColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppIcons.deleteAccountIc),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'delete_account'.tr(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.cError300,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ].paddingDirectional(bottom: 16),
            ),
          );
        },
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CacheImage(urlImage: '', profileImage: true, width: 100, height: 100, circle: true),
          ),
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_check_box.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/item_option_widget.dart';

class AddPersonView extends StatelessWidget {
  const AddPersonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'donor_details'),

      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CacheImage(urlImage: '', width: 60, height: 60),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Child to child'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                          const SizedBox(height: 4),
                          Text(
                            '${'In a world where the smallest act of giving can leave a big impact.'.tr()}:',
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50.withAlpha((.5 * 255).toInt())),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomPopupMenu(
                  nameField: 'donor_name',
                  selectedItem: DropDownModel(name: 'select_donor', value: -1),
                  items: [
                    DropDownModel(name: 'donor_name', value: 1),
                    DropDownModel(name: 'donor_name2', value: 2),
                    DropDownModel(name: 'donor_name3', value: 3),
                  ],
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'enter_sender_name',
                  textInputType: TextInputType.emailAddress,
                  nameField: 'sender_name',
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'enter_recipient_name',
                  textInputType: TextInputType.emailAddress,
                  nameField: 'recipient_name',
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'enter_recipient_email',
                  textInputType: TextInputType.emailAddress,
                  nameField: 'recipient_email',
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'enter_sender_email',
                  textInputType: TextInputType.emailAddress,
                  nameField: 'sender_email',
                ),

                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'message',
                  textInputType: TextInputType.emailAddress,
                  nameField: 'type_here',
                  maxLines: 3,
                  borderRadius: 10,
                ),
                CustomCheckBox(
                  fillTrueValue: AppColors.cP50,
                  onTap: (value) {},
                  widthBorder: 1.5,
                  borderRadius: 4,
                  borderColor: AppColors.cP50,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text('show_your_name'.tr(), style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50)),
                    ),
                  ),
                ),
                CustomCheckBox(
                  borderRadius: 4,
                  widthBorder: 1.5,
                  fillTrueValue: AppColors.cP50,
                  borderColor: AppColors.cP50,
                  checkBox: true,
                  onTap: (value) {},
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text('show_donation_amount'.tr(), style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50)),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.cP50.withAlpha((0.2 * 255).toInt())),
                      bottom: BorderSide(color: AppColors.cP50.withAlpha((0.2 * 255).toInt())),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.previewIc),
                      const SizedBox(width: 8),
                      Text('preview_the_message'.tr(), style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.primaryColor)),
                    ],
                  ),
                ),
              ].paddingDirectional(top: 16),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.cBorderButtonColor))),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        ItemOptionsWidget(option: 50, onTap: (option) {}),
                        ItemOptionsWidget(option: 100, onTap: (option) {}),
                        ItemOptionsWidget(option: 200, onTap: (option) {}),
                        ItemOptionsWidget(option: 500, onTap: (option) {}),
                        ItemOptionsWidget(option: 1000, onTap: (option) {}),
                      ],
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                controller: TextEditingController(),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'jod'.tr(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w400),
                  ),
                ),
                hintText: 'enter_amount'.tr(),
                textInputType: TextInputType.number,
              ),
              CustomTextButton(onPress: () {}, childText: 'add_person'),
            ].paddingDirectional(bottom: 12),
          ),
        ),
      ],
    );
  }
}

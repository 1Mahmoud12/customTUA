import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_check_box.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/campagin/view/presentation/widgets/select_card_widget.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/date_picker_dialog.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/phone_field_widget.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'send_as_a_e_card'),

      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('details'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(
                      '${'please_fill_out_the_fields_below'.tr()}:',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50.withAlpha((.5 * 255).toInt())),
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
                  hintText: 'enter_sender_email',
                  textInputType: TextInputType.emailAddress,
                  nameField: 'sender_email',
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'enter_recipient_email',
                  textInputType: TextInputType.emailAddress,
                  nameField: 'recipient_email',
                ),
                const PhoneFieldWidget(nameField: 'recipient_number'),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => Center(
                            child: BeautifulDatePicker(
                              firstDate: DateTime.now(),
                              onDateSelected: (dateSelected) {},
                              lastDate: DateTime.now().add(const Duration(days: 100)),
                            ),
                          ),
                    );
                  },
                  child: CustomTextFormField(
                    enable: false,
                    controller: TextEditingController(),
                    hintText: 'DD/MM/YYYY',
                    textInputType: TextInputType.emailAddress,
                    nameField: 'set_the_date',
                    prefixIcon: Padding(
                      padding: EdgeInsetsGeometry.only(
                        top: 16,
                        bottom: 16,
                        right: context.locale.languageCode == 'ar' ? 16 : 0,
                        left: context.locale.languageCode == 'ar' ? 0 : 16,
                      ),
                      child: SvgPicture.asset(AppIcons.dateIc),
                    ),
                  ),
                ),
              ].paddingDirectional(top: 16),
            ),
          ),
          const SizedBox(height: 16),
          const SelectCardWidget(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'message',
                  textInputType: TextInputType.emailAddress,
                  nameField: 'type_here',
                  maxLines: 3,
                  borderRadius: 10,
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
                      Text('preview_e_card'.tr(), style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.primaryColor)),
                    ],
                  ),
                ),
                CustomCheckBox(
                  checkBox: true,
                  fillTrueValue: AppColors.cP50,
                  borderColor: AppColors.cP50,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'please_send_me_a_copy_of_the_e_card_when_it_is_sent'.tr(),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                CustomTextButton(onPress: () {}, childText: 'send_e_card'.tr()),
                const SizedBox(height: 16),
              ].paddingDirectional(top: 16),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart' show CustomPopupMenu;
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/campagin/view/presentation/widgets/select_card_widget.dart' show SelectCardWidget;
import 'package:tua/feature/sponsorship/view/presentation/widgets/date_picker_dialog.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/phone_field_widget.dart';

class CreateCampaignView extends StatelessWidget {
  const CreateCampaignView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'create_your_campaign'),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text('start_your_campaign_message'.tr(), style: Theme.of(context).textTheme.displayMedium),

                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'enter_your_name',
                  textInputType: TextInputType.name,
                  nameField: 'your_name',
                ),
                const PhoneFieldWidget(nameField: 'mobile_number'),

                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'enter_your_email',
                  textInputType: TextInputType.emailAddress,
                  nameField: 'your_email',
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'enter_your_campaign_name',
                  textInputType: TextInputType.emailAddress,
                  nameField: 'campaign_name',
                ),
                CustomPopupMenu(
                  nameField: 'reason',
                  selectedItem: DropDownModel(name: 'selected_reason', value: -1),
                  items: [
                    DropDownModel(name: 'reason_1', value: 1),
                    DropDownModel(name: 'reason_2', value: 2),
                    DropDownModel(name: 'reason_3', value: 3),
                    DropDownModel(name: 'reason_4', value: 4),
                    DropDownModel(name: 'reason_5', value: 5),
                  ],
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'Ex: 2000 JOD',
                  textInputType: TextInputType.emailAddress,
                  nameField: 'donation_gaol',
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => Center(
                                  child: BeautifulDatePicker(firstDate: DateTime.now(), initialDate: DateTime.now(), onDateSelected: (date) {}),
                                ),
                          );
                        },
                        child: CustomTextFormField(
                          enable: false,
                          controller: TextEditingController(),
                          hintText: 'DD/MM/YYYY',
                          textInputType: TextInputType.emailAddress,
                          nameField: 'start_date',
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
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => Center(
                                  child: BeautifulDatePicker(firstDate: DateTime.now(), initialDate: DateTime.now(), onDateSelected: (date) {}),
                                ),
                          );
                        },
                        child: CustomTextFormField(
                          enable: false,
                          controller: TextEditingController(),
                          hintText: 'DD/MM/YYYY',
                          textInputType: TextInputType.emailAddress,
                          nameField: 'end_date',
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
                    ),
                  ],
                ),
              ].paddingDirectional(top: 16),
            ),
          ),

          const SelectCardWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextButton(padding: const EdgeInsets.symmetric(vertical: 18), onPress: () {}, childText: 'submit'),
          ),
        ].paddingDirectional(top: 16),
      ),
    );
  }
}

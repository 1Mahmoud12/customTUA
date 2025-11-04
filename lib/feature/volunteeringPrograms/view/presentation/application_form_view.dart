import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/custom_radio_button.dart';
import 'package:tua/core/component/drop_menu.dart' show CustomPopupMenu;
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/constants_enums.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/date_picker_dialog.dart' show BeautifulDatePicker;
import 'package:tua/feature/sponsorship/view/presentation/widgets/phone_field_widget.dart';

class ApplicationFormView extends StatelessWidget {
  const ApplicationFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'application_form'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Text('To apply, please fill out the fields below!'.tr(), style: Theme.of(context).textTheme.displayMedium),

          CustomTextFormField(
            controller: TextEditingController(),
            hintText: 'enter_your_name',
            textInputType: TextInputType.name,
            nameField: 'your_name',
          ),

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
          CustomRadioListButton(
            title: 'National or International Number',
            items: [RadioButtonModel(id: 1, name: 'National Phone Number'), RadioButtonModel(id: 2, name: 'International Number')],
          ),
          const PhoneFieldWidget(nameField: 'mobile_number'),

          CustomPopupMenu(
            nameField: 'nationality',
            selectedItem: DropDownModel(name: 'select_nationality', value: -1),
            items: EnumNationality.values.map((e) => DropDownModel(name: e.name, value: e.index)).toList(),
          ),
          CustomPopupMenu(
            nameField: 'gender',
            selectedItem: DropDownModel(name: 'select_gender', value: -1),
            items: EnumGender.values.map((e) => DropDownModel(name: e.name, value: e.index)).toList(),
          ),
          CustomPopupMenu(
            nameField: 'country',
            selectedItem: DropDownModel(name: 'select_country', value: -1),
            items: EnumCountry.values.map((e) => DropDownModel(name: e.name, value: e.index)).toList(),
          ),
          CustomPopupMenu(
            nameField: 'city',
            selectedItem: DropDownModel(name: 'select_country', value: -1),
            items: EnumCountry.values.map((e) => DropDownModel(name: e.name, value: e.index)).toList(),
          ),

          CustomRadioListButton(
            title: 'occupation',
            items: [
              RadioButtonModel(id: 1, name: 'Student - School'),
              RadioButtonModel(id: 2, name: 'Student - University'),
              RadioButtonModel(id: 3, name: 'Individual'),
              RadioButtonModel(id: 4, name: 'other'),
            ],
          ),
          CustomTextFormField(
            controller: TextEditingController(),
            hintText: 'enter_your_email',
            textInputType: TextInputType.emailAddress,
            nameField: 'your_email',
          ),
          CustomRadioListButton(
            title: 'Have you participated volunteered with Tkiyet Um Ali in the past 3 years?',
            items: [RadioButtonModel(id: 1, name: 'yes'), RadioButtonModel(id: 2, name: 'no')],
          ),
          CustomTextFormField(controller: TextEditingController(), hintText: 'if_yes_specify?', textInputType: TextInputType.emailAddress),
          CustomTextFormField(
            controller: TextEditingController(),
            nameField: 'How did you hear about Tkiyet Um Ali volunteering programs?',
            hintText: 'enter_reason',
            textInputType: TextInputType.emailAddress,
          ),
        ].paddingDirectional(top: 16),
      ),
    );
  }
}

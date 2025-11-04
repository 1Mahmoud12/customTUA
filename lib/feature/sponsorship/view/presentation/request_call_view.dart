import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/date_picker_dialog.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/phone_field_widget.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/time_picker_dialog.dart';

class RequestCallView extends StatelessWidget {
  const RequestCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'request_call'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Text(
            'The account administrator will contact the sponsored families to obtain their approval to contact first. If the response is positive for the call, this will be arranged &  the  donor  will be informed by responding to the request as soon as possible!',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          CustomTextFormField(
            controller: TextEditingController(),
            hintText: 'enter_your_name',
            textInputType: TextInputType.name,
            nameField: 'your_name',
          ),
          CustomTextFormField(
            controller: TextEditingController(),
            hintText: 'enter_your_email',
            textInputType: TextInputType.emailAddress,
            nameField: 'your_email',
          ),
          const PhoneFieldWidget(nameField: 'mobile_number'),
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
          InkWell(
            onTap: () {
              showDialog(context: context, builder: (context) => Center(child: BeautifulTimePicker(onTimeSelected: (timeSelected) {})));
            },
            child: CustomTextFormField(
              enable: false,
              controller: TextEditingController(),
              hintText: '6:00 PM',
              textInputType: TextInputType.emailAddress,
              nameField: 'select_time',
            ),
          ),
          CustomTextFormField(
            controller: TextEditingController(),
            hintText: 'enter_message',
            textInputType: TextInputType.emailAddress,
            nameField: 'message',
            maxLines: 5,
            borderRadius: 10,
          ),
          CustomTextButton(onPress: () {}, childText: 'submit'),
        ].paddingDirectional(top: 16),
      ),
    );
  }
}

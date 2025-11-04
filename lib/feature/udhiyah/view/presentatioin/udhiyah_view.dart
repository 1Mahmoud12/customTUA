import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/udhiyah/view/presentatioin/success_udhiyah_view.dart';
import 'package:tua/feature/udhiyah/view/presentatioin/widgets/item_udhiyah_widget.dart';

import '../../../../core/component/custom_app_bar.dart' show customAppBar;

class UdhiyahView extends StatelessWidget {
  const UdhiyahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'check_your_udhiyah'),
      body: ListView(
        children: [
          Image.asset(AppImages.checkUdhiyah),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const ItemUdhiyahWidget(title: 'Check the status of your Udhiyah now, type your receipt number here then click on the button below.'),
                const ItemUdhiyahWidget(title: 'Check the status of your Udhiyah now, type your receipt number here then click on the button below.'),
                const ItemUdhiyahWidget(title: 'Check the status of your Udhiyah now, type your receipt number here then click on the button below.'),
                const SizedBox(height: 10),
                CustomTextFormField(
                  outPadding: EdgeInsets.zero,
                  controller: TextEditingController(),
                  nameField: 'receipt_number',
                  hintText: '2024-123456',
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ].paddingDirectional(bottom: 4),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.cBorderButtonColor))),
          child: CustomTextButton(
            onPress: () {
              context.navigateToPage(const SuccessUdhiyahView());
            },
            childText: 'submit',
          ),
        ),
      ],
    );
  }
}

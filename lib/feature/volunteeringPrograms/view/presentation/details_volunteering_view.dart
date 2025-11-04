import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/application_form_view.dart';

class DetailsVolunteeringView extends StatelessWidget {
  const DetailsVolunteeringView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'name_volunteering_program'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(),
          CacheImage(urlImage: '', width: double.infinity, height: context.screenHeight * .3, fit: BoxFit.cover, borderRadius: 10),
          Text('${'description'.tr()}: ', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400)),
          Text(
            'Packaging food parcels is a main volunteering program that offers  volunteers  the  opportunity  to participate  in  packaging  Tkiyet  Um  Ali’s  monthly  food  parcels  at  its  warehouses  in  AlQastal, allowing them to better understand the magnitude of operations inside the warehouses including packaging the food items inside the food parcels and their quantities, depending on the  category  of parcel.'
                .tr(),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400),
          ),
          Text('${'volunteering_conditions'.tr()}: ', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 10,
                height: 10,
                decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting.'.tr(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          CustomTextButton(
            onPress: () {
              context.navigateToPage(const ApplicationFormView());
            },
            childText: 'apply_now',
          ),
        ].paddingDirectional(top: 16),
      ),
    );
  }
}

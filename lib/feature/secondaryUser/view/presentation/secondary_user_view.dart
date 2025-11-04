import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/feature/secondaryUser/view/presentation/widgets/add_user_dialog.dart';

class SecondaryUserView extends StatelessWidget {
  const SecondaryUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'secondary_user'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          const HeaderWidget(),
          const ItemWidget(),
          const ItemWidget(),
          const SizedBox(height: 16),
          Row(
            children: [
              CustomTextButton(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                onPress: () {
                  showAddNewUserDialog(context, onPress: () {});
                },
                childText: 'add_new_user'.tr(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffB4BBC6)))),
      child: Row(
        children: [
          Expanded(child: Text('Mahmoud'.tr(), style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500))),
          Expanded(child: Text('Secondary'.tr(), style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500))),
          Expanded(
            child: Text(
              'mahmoud@gmail.com'.tr(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffB4BBC6)), bottom: BorderSide(color: Color(0xffB4BBC6)))),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'user_name'.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: AppColors.cP50.withAlpha((0.5 * 255).toInt()), fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              'class'.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: AppColors.cP50.withAlpha((0.5 * 255).toInt()), fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              'email'.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: AppColors.cP50.withAlpha((0.5 * 255).toInt()), fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

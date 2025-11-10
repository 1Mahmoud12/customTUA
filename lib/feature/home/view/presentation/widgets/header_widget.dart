import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/notifications/view/presentation/notifications_view.dart';
import 'package:tua/feature/profileDetails/view/presentation/profile_details_view.dart';

import '../../../../navigation/view/presentation/widgets/login_required_dialog.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (userCacheValue==null ) {
            loginRequiredDialog(context);
            return;
          }
          context.navigateToPage(const ProfileDetailsView());
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(border: Border.all(color: AppColors.primaryColor, width: 2), shape: BoxShape.circle),
              child: CacheImage(urlImage: userCacheValue?.photoPath ?? '', width: 36, height: 36, circle: true, profileImage: true),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('hello,'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP800)),
                  Text(
                    userCacheValue?.firstName ?? 'Guest'.tr(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, height: 1.19),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                context.navigateToPage(const NotificationsView());
              },
              child: Badge(
                alignment: AlignmentDirectional.topCenter,
                backgroundColor: AppColors.cHumanitarianAidColor,
                label: Text('2', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
                child: Padding(padding: const EdgeInsets.all(2.0), child: SvgPicture.asset(AppIcons.notificationIc)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

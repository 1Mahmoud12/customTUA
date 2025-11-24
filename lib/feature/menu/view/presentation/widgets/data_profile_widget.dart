import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/navigation/view/presentation/widgets/login_required_dialog.dart';
import 'package:tua/feature/profileDetails/view/presentation/profile_details_view.dart';

class DataProfileWidget extends StatelessWidget {
  const DataProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (userCacheValue == null) {
          loginRequiredDialog(context);
          return;
        }
        context.navigateToPage(const ProfileDetailsView(), pageTransitionType: PageTransitionType.rightToLeft);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(border: Border.all(color: AppColors.cBorderButtonColor), borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            CacheImage(urlImage: userCacheValue?.photoPath ?? '', width: 50, height: 50, fit: BoxFit.fill, circle: true, profileImage: true),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userCacheValue?.firstName ?? 'guest'.tr(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userCacheValue?.email ?? 'guest@example.com'.tr(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.greyG600, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primaryColor)),
              child: SvgPicture.asset(AppIcons.editProfileIc),
            ),
          ],
        ),
      ),
    );
  }
}

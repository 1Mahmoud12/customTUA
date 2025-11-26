import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/component/sliders/slider_custom.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/donations/data/models/donation_program_model.dart';
import 'package:tua/feature/donations/view/manager/donation_programs_cubit.dart';
import 'package:tua/feature/donationsDetails/view/presentation/donation_details_view.dart';
import 'package:tua/feature/home/view/presentation/view_all_quick_donations_view.dart';

class QuickDonations extends StatelessWidget {
  const QuickDonations({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DonationProgramsCubit, DonationProgramsState>(
      listener: (context, state) {
        if (state is DonationProgramsError) {
          customShowToast(context, state.message, showToastStatus: ShowToastStatus.error);
        }
      },
      builder: (context, state) {
        List<DonationProgramModel> programs = [];

        if (state is DonationProgramsLoaded) {
          programs = state.programs;
        }

        return Container(
          color: AppColors.scaffoldBackGround,
          child: Column(
            children: [
              SeeAllWidget(
                title: 'quick_donations',
                onTap: () {
                  context.navigateToPage(const ViewAllQuickDonationsView());
                },
              ),
              const SizedBox(height: 16),
              // ⏳ Loading
              if (state is DonationProgramsLoading && programs.isEmpty)
                const Padding(padding: EdgeInsets.symmetric(vertical: 100), child: LoadingWidget())
              // ❌ Error or Empty
              else if ((state is DonationProgramsError && programs.isEmpty) || programs.isEmpty)
                const SizedBox.shrink()
              // ✅ Loaded — show donation programs (limit to 5)
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 16),
                      ...programs.take(5).map((program) => ItemDonationsWidget(donation: program)),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class ItemDonationsWidget extends StatelessWidget {
  final DonationProgramModel donation;

  const ItemDonationsWidget({super.key, required this.donation});

  Color _parseColor(String colorHex) {
    try {
      return Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
    } catch (e) {
      return AppColors.cRed900;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tagColor = _parseColor(donation.color);

    return InkWell(
      onTap: () {
        context.navigateToPage(DonationDetailsView(id: donation.id));
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: context.screenWidth * .8,
        // height: 300.h,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.scaffoldBackGround,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          shadows: const [
            BoxShadow(color: Color(0x33B6B6B6), blurRadius: 30, offset: Offset(0, 20), spreadRadius: 0),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: CacheImage(
                    urlImage: donation.image,
                    width: double.infinity,
                    height: 160.h,
                    fit: BoxFit.cover,
                    borderRadius: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (donation.tagIcon.isNotEmpty || donation.color.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                          decoration: BoxDecoration(
                            color: tagColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (donation.tagIcon.isNotEmpty)
                                CacheImage(
                                  urlImage: donation.tagIcon,
                                  width: 16,
                                  height: 16,
                                  fit: BoxFit.contain,
                                )
                              else
                                SvgPicture.asset(
                                  AppIcons.incidentsIc,
                                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                                ),
                              const SizedBox(width: 8),
                              Text(
                                donation.tag.isEmpty ? '' : donation.tag.tr(),
                                style: Theme.of(
                                  context,
                                ).textTheme.displayMedium?.copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      SvgPicture.asset(AppIcons.shareIc),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donation.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  if (donation.goal.isNotEmpty && donation.raised.isNotEmpty)
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'raised'.tr(),
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(color: AppColors.cRed900),
                            ),
                            const SizedBox(height: 6),
                            Text(donation.raised, style: Theme.of(context).textTheme.displayMedium),
                            const SizedBox(height: 4),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'goal'.tr(),
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(color: AppColors.cRed900),
                            ),
                            const SizedBox(height: 6),
                            Text(donation.goal, style: Theme.of(context).textTheme.displayMedium),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ],
                    ),
                  if (donation.progress > 0)
                    SliderCustom(
                      valueSlider: donation.progress.toDouble() < 0 ? 0 : donation.progress.toDouble(),
                    ),
                  if (donation.campaignReport != null && donation.campaignReport!.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Donations collected. Review the campaign report',
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SvgPicture.asset(AppIcons.downloadIc),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

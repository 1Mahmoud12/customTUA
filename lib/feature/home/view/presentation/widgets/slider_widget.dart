import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/state_app_widget.dart';
import 'package:tua/feature/home/view/manager/cubit.dart';
import 'package:tua/feature/home/view/manager/state.dart';

class SliderWidget extends StatefulWidget {
  final HomeCubit homeCubit;

  const SliderWidget({super.key, required this.homeCubit});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late final HomeCubit homeCubit;
  late PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentIndex = 0;
  bool _isUserScrolling = false;

  @override
  void initState() {
    super.initState();
    homeCubit = widget.homeCubit;
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _startAutoScroll();
      await homeCubit.getAllSlider(context: context);
    });
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        resumeCallBack: () async {
          if (mounted) {
            if (userCacheValue?.accessToken != null) {
              await homeCubit.getAllSlider(context: context);
            }
            setState(() {});
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if ((ConstantsModels.sliderModel?.data?.isNotEmpty ?? false) && !_isUserScrolling) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % (ConstantsModels.sliderModel?.data ?? []).length;
          if (_pageController.hasClients) {
            _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
          }
        });
      }
    });
  }

  void _handlePageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocProvider.value(
          value: homeCubit,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder:
                (context, state) =>
                    (ConstantsModels.sliderModel?.data ?? []).isNotEmpty
                        ? AnimatedOpacity(
                          duration: Durations.long1,
                          opacity: (ConstantsModels.sliderModel?.data ?? []).isNotEmpty ? 1 : 0,
                          child: SizedBox(
                            height: context.screenHeight * .22,
                            width: context.screenWidth,
                            child: Listener(
                              onPointerDown: (_) {
                                // User started interacting with the slider
                                _isUserScrolling = true;
                              },
                              onPointerUp: (_) {
                                // User finished interacting with the slider
                                Future.delayed(const Duration(milliseconds: 500), () {
                                  _isUserScrolling = false;
                                });
                              },
                              child: PageView.builder(
                                controller: _pageController,
                                onPageChanged: _handlePageChanged,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      // if (ConstantsModels.sliderModel?.data?[index].product != null) {
                                      //   context.navigateToPage(
                                      //     DetailsMealView(mealId: (ConstantsModels.sliderModel?.data?[index].product?.id ?? 0).toInt()),
                                      //   );
                                      // } else if (ConstantsModels.sliderModel?.data?[index].restaurant != null) {
                                      //   context.navigateToPage(
                                      //     BlocProvider(
                                      //       create: (context) => DetailsRestaurantCubit(),
                                      //       child: DetailsRestaurantView(
                                      //         restaurantBranchId: (ConstantsModels.sliderModel?.data?[index].restaurant ?? 0).toInt(),
                                      //       ),
                                      //     ),
                                      //   );
                                      // }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: context.screenWidth * .02),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CacheImage(
                                          urlImage: ConstantsModels.sliderModel!.data![index].image ?? '',
                                          width: context.screenWidth * .7,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: ConstantsModels.sliderModel?.data?.length ?? 0,
                              ),
                            ),
                          ),
                        )
                        : const SizedBox(),
          ),
        ),
        const SizedBox(height: 6),
        BlocProvider.value(
          value: homeCubit,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder:
                (context, state) =>
                    (ConstantsModels.sliderModel?.data ?? []).isNotEmpty
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            ConstantsModels.sliderModel?.data?.length ?? 0,
                            (index) => AnimatedContainer(
                              duration: Durations.long1,
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              height: 8.h,
                              width: _currentIndex == index ? 28.w : 8.w,
                              decoration: BoxDecoration(
                                color: _currentIndex == index ? AppColors.primaryColor : AppColors.black100,
                                borderRadius: BorderRadius.circular(5),
                                //border: Border.all(color: _currentIndex == index ? AppColors.transparent : AppColors.primaryColor),
                              ),
                            ),
                          ),
                        )
                        : const SizedBox(),
          ),
        ),
      ],
    );
  }
}

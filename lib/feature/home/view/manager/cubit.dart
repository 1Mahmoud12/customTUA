import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/feature/home/data/homeDataSource/home_data_source.dart';
import 'package:tua/feature/home/view/manager/state.dart';
import 'package:tua/main.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit of(BuildContext context) => BlocProvider.of<HomeCubit>(context);

  final HomeDataSource homeDataSource = HomeDataSourceImpl();

  Future<void> getAllSlider({required BuildContext context}) async {
    emit(GetSlidersLoadingState());
    await homeDataSource.getSlider(limit: 10, categorySlug: 'HomePage-Slider-MobileApp').then((
      value,
    ) async {
      value.fold(
        (l) {
          //  Utils.showToast(title: l.errMessage, state: UtilState.error);
          // failureModalBottomSheetWithNoReason(context, l.errMessage, onPress: () {});
          emit(GetSlidersErrorState(l.errMessage));
        },
        (r) async {
          userCache?.put(sliderCacheKey, jsonEncode(r.toJson()));
          logger.i(r.toJson());
          ConstantsModels.sliderModel = r;

          emit(GetSlidersSuccessState());
        },
      );
    });
  }

  void changeState() {
    emit(HomeChangeState());
  }
}

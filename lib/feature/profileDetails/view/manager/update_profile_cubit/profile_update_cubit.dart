import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/constants_models.dart';
import '../../../../../core/utils/errorLoadingWidgets/dialog_loading_animation.dart';
import '../../../data/data_source/profile_details_data_source.dart';
import 'profile_update_state.dart';

class ProfileUpdateCubit extends Cubit<ProfileUpdateState> {
  final ProfileDetailsDataSource dataSource;

  ProfileUpdateCubit(this.dataSource) : super(ProfileUpdateInitial());
  TextEditingController firstNameController = TextEditingController(
    text: userCacheValue?.firstName ?? '',
  );
  TextEditingController lastNameController = TextEditingController(text: userCacheValue?.lastName ?? '');
  TextEditingController phoneController = TextEditingController(text: userCacheValue?.phone ?? '');

  @override
  Future<void> close() async {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.close();
  }

  Future<void> updateProfile(BuildContext context) async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneController.text.isEmpty) {
      emit(const ProfileUpdateFailure('fill_all_fields'));
      return;
    }
    emit(ProfileUpdateLoading());
    animationDialogLoading(context);

    final result = await dataSource.updateProfile(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phone: phoneController.text,
    );

    result.fold(
      (failure) {
        closeDialog(context);
        emit(ProfileUpdateFailure(failure.errMessage));
      },
      (r) async {
        closeDialog(context);

        FocusScope.of(context).unfocus();

        ConstantsModels.loginModel = r;
        Constants.token = r.data?.userInfo?.accessToken ?? '';
        await userCache?.put(userCacheKey, jsonEncode(r.toJson()));
        userCacheValue = r.data?.userInfo;
        firstNameController.text = userCacheValue?.firstName ?? '';
        lastNameController.text = userCacheValue?.lastName ?? '';
        emit(ProfileUpdateSuccess());
        context.navigateToPage(NavigationView(customIndex: 0));
      },
    );
  }
}

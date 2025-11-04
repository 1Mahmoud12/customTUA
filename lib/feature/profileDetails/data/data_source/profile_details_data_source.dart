import 'package:dartz/dartz.dart';
import 'package:tua/feature/auth/data/models/login_model.dart';

import '../../../../core/network/errors/failures.dart';

abstract class ProfileDetailsDataSource{
  Future<Either<Failure, Unit>> changePassword({
    required String newPassword,
    required String confirmNewPassword
});
  Future<Either<Failure,LoginModel>> updateProfile({
    required String firstName,
    required String lastName,
    required String phone
});
}
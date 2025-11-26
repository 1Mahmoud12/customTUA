import 'package:dartz/dartz.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/feature/checkout_as_a_visitor/data/models/checkout_as_visitor_parms.dart';

abstract class CheckoutAsVisitorDataSource {
  Future<Either<Failure, Unit>> checkoutAsVisitor(CheckoutAsVisitorParms parms);
  Future<Either<Failure, Unit>> verifyOtp(String otp);
}

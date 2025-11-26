import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_source/checkout_as_visitor_data_source.dart';
import '../../data/models/checkout_as_visitor_parms.dart';
import '../../../../core/network/errors/failures.dart';

part 'checkout_as_visitor_state.dart';

class CheckoutAsVisitorCubit extends Cubit<CheckoutAsVisitorState> {
  final CheckoutAsVisitorDataSource dataSource;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  CheckoutAsVisitorCubit({required this.dataSource}) : super(CheckoutAsVisitorInitial());

  // Function to submit the form
  Future<void> checkoutAsVisitor() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(CheckoutAsVisitorLoading());

    final parms = CheckoutAsVisitorParms(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
    );

    final Either<Failure, Unit> result = await dataSource.checkoutAsVisitor(parms);

    result.fold(
      (failure) => emit(CheckoutAsVisitorError(message: failure.errMessage)),
      (_) => emit(CheckoutAsVisitorSuccess()),
    );
  }

  // Optional: Dispose controllers
  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}

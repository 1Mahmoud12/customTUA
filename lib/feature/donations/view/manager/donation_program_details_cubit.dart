import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tua/feature/donations/data/data_source/donation_programs_data_source.dart';
import 'package:tua/feature/donations/data/models/donation_program_details_model.dart';
import 'package:tua/core/network/errors/failures.dart';

part 'donation_program_details_state.dart';

class DonationProgramDetailsCubit extends Cubit<DonationProgramDetailsState> {
  final DonationProgramsDataSource dataSource;

  DonationProgramDetailsCubit(this.dataSource)
      : super(DonationProgramDetailsInitial());


  Future<void> fetchDonationProgramById(int id) async {
    emit(DonationProgramDetailsLoading());
    final result = await dataSource.getDonationProgramById(id);

    result.fold(
          (failure) => emit(
        DonationProgramDetailsError(
          message: failure.errMessage ?? 'something_went_wrong',
        ),
      ),
          (program) => emit(DonationProgramDetailsLoaded(program)),
    );
  }
}

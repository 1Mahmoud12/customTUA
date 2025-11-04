import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  OTPCubit() : super(OTPInitial()) {
    _startTimer();
  }
  TextEditingController codeController = TextEditingController();

  Timer? _timer;
  int _seconds = 120;

  void _startTimer() {
    // ignore: prefer_single_quotes
    emit(OTPTimerRunning("02:00"));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
        emit(OTPExpired());
      } else {
        _seconds--;
        final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
        final seconds = (_seconds % 60).toString().padLeft(2, '0');
        // ignore: prefer_single_quotes
        emit(OTPTimerRunning("$minutes:$seconds"));
      }
    });
  }

  void resendCode() {
    _seconds = 120;
    _startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

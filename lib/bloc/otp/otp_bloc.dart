// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/otp/otp_event.dart';
import 'package:lunapos_akpsi/bloc/otp/otp_state.dart';
import 'package:lunapos_akpsi/constants/dummy_user.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> {
  OTPBloc() : super(OTPInitialState()) {
    on<PostOTP>((event, emit) async {
      emit(OTPLoadingState());

      try {
        if (event.otp == validOtp) {
          emit(
            OTPLoadedState(),
          );
        } else {
          throw ("Invalid OTP");
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        emit(OTPErrorState(error.toString()));
      }
    });
  }
}

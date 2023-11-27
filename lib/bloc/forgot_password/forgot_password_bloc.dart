// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/forgot_password/forgot_password_event.dart';
import 'package:lunapos_akpsi/bloc/forgot_password/forgot_password_state.dart';
import 'package:lunapos_akpsi/constants/dummy_user.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitialState()) {
    on<PostForgotPassword>((event, emit) async {
      emit(ForgotPasswordLoadingState());

      try {
        if (event.phoneNumber == validPhoneNumber) {
          emit(
            ForgotPasswordLoadedState(),
          );
        } else {
          throw ("Nomor Telepon tidak terdaftar");
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        emit(ForgotPasswordErrorState(error.toString()));
      }
    });
  }
}

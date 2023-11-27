// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/register/register_event.dart';
import 'package:lunapos_akpsi/bloc/register/register_state.dart';
import 'package:lunapos_akpsi/constants/dummy_user.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitialState()) {
    on<PostRegister>((event, emit) async {
      emit(RegisterLoadingState());

      try {
        if (event.controller['phoneNumber']?.text != validPhoneNumber &&
            event.controller['password']?.text != '') {
          emit(
            RegisterLoadedState(
              userName,
              points,
            ),
          );
        } else if (event.controller['phoneNumber']?.text == '' &&
            event.controller['password']?.text == '') {
          throw ("Invalid data");
        } else {
          throw ("Phone number is already registered");
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        emit(RegisterErrorState(error.toString()));
      }
    });
  }
}

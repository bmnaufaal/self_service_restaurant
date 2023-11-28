// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/constants/dummy_user.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<PostLogin>((event, emit) async {
      emit(LoginLoadingState());

      try {
        if ((event.controller['phoneNumber']?.text == validPhoneNumber ||
                event.controller['phoneNumber']?.text == validPhoneNumber2) &&
            event.controller['password']?.text == validPassword) {
          emit(
            LoginLoadedState(
              userName,
              points,
            ),
          );
        } else {
          throw ('Invalid Credentials');
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        emit(LoginErrorState(error.toString()));
      }
    });
  }
}

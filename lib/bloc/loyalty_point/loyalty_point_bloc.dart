// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/loyalty_point/loyalty_point_event.dart';
import 'package:lunapos_akpsi/bloc/loyalty_point/loyalty_point_state.dart';

class LoyaltyPointBloc extends Bloc<LoyaltyPointEvent, LoyaltyPointState> {
  LoyaltyPointBloc() : super(LoyaltyPointInitialState()) {
    on<PostLoyaltyPoint>((event, emit) async {
      emit(LoyaltyPointLoadingState());

      try {
        print('points: ${event.points - event.cost}');
        if (event.points - event.cost >= 0) {
          emit(LoyaltyPointLoadedState(event.discount));
        } else {
          throw ("Insufficient points");
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        emit(LoyaltyPointErrorState(error.toString()));
      }
    });
  }
}

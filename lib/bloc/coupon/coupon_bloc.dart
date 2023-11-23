// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/coupon/coupon_event.dart';
import 'package:lunapos_akpsi/bloc/coupon/coupon_state.dart';
import 'package:lunapos_akpsi/constants/dummy_user.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(CouponInitialState()) {
    on<PostCoupon>((event, emit) async {
      emit(CouponLoadingState());

      try {
        if (event.coupon == validCoupon) {
          emit(CouponLoadedState());
        } else {
          throw ("Coupon is not valid");
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        emit(CouponErrorState(error.toString()));
      }
    });
  }
}

import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class CouponState extends Equatable {}

class CouponInitialState extends CouponState {
  @override
  List<Object?> get props => [];
}

class CouponLoadingState extends CouponState {
  @override
  List<Object?> get props => [];
}

class CouponLoadedState extends CouponState {
  @override
  List<Object?> get props => [];
}

class CouponErrorState extends CouponState {
  CouponErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}

import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class LoyaltyPointState extends Equatable {}

class LoyaltyPointInitialState extends LoyaltyPointState {
  @override
  List<Object?> get props => [];
}

class LoyaltyPointLoadingState extends LoyaltyPointState {
  @override
  List<Object?> get props => [];
}

class LoyaltyPointLoadedState extends LoyaltyPointState {
  LoyaltyPointLoadedState(this.discount);
  final int discount;

  @override
  List<Object?> get props => [];
}

class LoyaltyPointErrorState extends LoyaltyPointState {
  LoyaltyPointErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}

import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class OTPState extends Equatable {}

class OTPInitialState extends OTPState {
  @override
  List<Object?> get props => [];
}

class OTPLoadingState extends OTPState {
  @override
  List<Object?> get props => [];
}

class OTPLoadedState extends OTPState {
  @override
  List<Object?> get props => [];
}

class OTPErrorState extends OTPState {
  OTPErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}

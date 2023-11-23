import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class ForgotPasswordState extends Equatable {}

class ForgotPasswordInitialState extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordLoadingState extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordLoadedState extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordErrorState extends ForgotPasswordState {
  ForgotPasswordErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}

import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadedState extends LoginState {
  LoginLoadedState(
    this.userName,
    this.points,
  );

  final String userName;
  final int points;

  @override
  List<Object?> get props => [];
}

class LoginErrorState extends LoginState {
  LoginErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}

import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class RegisterState extends Equatable {}

class RegisterInitialState extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterLoadedState extends RegisterState {
  RegisterLoadedState(
    this.userName,
    this.points,
  );

  final String userName;
  final int points;

  @override
  List<Object?> get props => [];
}

class RegisterErrorState extends RegisterState {
  RegisterErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}

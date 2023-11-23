import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class PostForgotPassword extends ForgotPasswordEvent {
  const PostForgotPassword(this.phoneNumber);

  final String phoneNumber;
  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class OTPEvent extends Equatable {
  const OTPEvent();
}

class PostOTP extends OTPEvent {
  const PostOTP(
    this.otp,
  );

  final String otp;
  @override
  List<Object?> get props => [];
}

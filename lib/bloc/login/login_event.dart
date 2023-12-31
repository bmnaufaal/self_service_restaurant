import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class PostLogin extends LoginEvent {
  const PostLogin(
    this.controller,
  );

  final Map<String, TextEditingController> controller;
  @override
  List<Object?> get props => [];
}

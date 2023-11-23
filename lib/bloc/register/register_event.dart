import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class PostRegister extends RegisterEvent {
  const PostRegister(
    this.controller,
  );

  final Map<String, TextEditingController> controller;
  @override
  List<Object?> get props => [];
}

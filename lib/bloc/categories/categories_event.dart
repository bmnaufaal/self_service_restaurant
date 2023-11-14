import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class ChangeStatus extends CategoriesEvent {
  ChangeStatus(this.selectedCategory);

  final String selectedCategory;

  @override
  List<Object?> get props => [];
}

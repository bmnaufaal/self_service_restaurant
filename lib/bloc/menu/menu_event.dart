import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class GetMenuItem extends MenuEvent {
  @override
  List<Object?> get props => [];
}

class SearchItem extends MenuEvent {
  const SearchItem(this.search);
  final String search;
  @override
  List<Object?> get props => [];
}

class SelectCategoryItem extends MenuEvent {
  const SelectCategoryItem(this.category);
  final String category;
  @override
  List<Object?> get props => [];
}

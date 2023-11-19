import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';

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

class AddCountItem extends MenuEvent {
  const AddCountItem(this.list, this.name);
  final List<MenuItem> list;
  final String name;
  @override
  List<Object?> get props => [];
}

class RemoveCountItem extends MenuEvent {
  const RemoveCountItem(this.list, this.name);
  final List<MenuItem> list;
  final String name;
  @override
  List<Object?> get props => [];
}

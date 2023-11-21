import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';

@immutable
abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class GetDetailItem extends DetailEvent {
  const GetDetailItem(this.list, this.name);
  final List<MenuItem> list;
  final String name;

  List<Object?> get props => [];
}

class AddCountDetailItem extends DetailEvent {
  const AddCountDetailItem(this.item);
  final MenuItem item;
  @override
  List<Object?> get props => [];
}

class RemoveCountDetailItem extends DetailEvent {
  const RemoveCountDetailItem(this.item);
  final MenuItem item;
  @override
  List<Object?> get props => [];
}

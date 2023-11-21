import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
}

class AddCountCart extends CartEvent {
  const AddCountCart(this.cart, this.name);
  final List<MenuItem> cart;
  final String name;
  @override
  List<Object?> get props => [];
}

class RemoveCountCart extends CartEvent {
  const RemoveCountCart(this.cart, this.name);
  final List<MenuItem> cart;
  final String name;
  @override
  List<Object?> get props => [];
}

class DeleteItemCart extends CartEvent {
  const DeleteItemCart(this.cart, this.name);
  final List<MenuItem> cart;
  final String name;
  @override
  List<Object?> get props => [];
}

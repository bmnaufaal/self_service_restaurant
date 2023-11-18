import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
}

class AddCartItem extends CartEvent {
  const AddCartItem(
    this.cart,
    this.name,
  );
  final List<MenuItem> cart;
  final String name;

  @override
  List<Object?> get props => [];
}

class RemoveCartItem extends CartEvent {
  const RemoveCartItem(
    this.cart,
    this.name,
  );
  final List<MenuItem> cart;
  final String name;

  @override
  List<Object?> get props => [];
}

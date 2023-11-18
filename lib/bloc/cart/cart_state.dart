import 'package:equatable/equatable.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';

abstract class CartState extends Equatable {}

class CartInitialState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadingState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadedState extends CartState {
  CartLoadedState(this.data);
  final List<MenuItem> data;

  @override
  List<Object> get props => [data];
}

class CartErrorState extends CartState {
  @override
  List<Object> get props => [];
}

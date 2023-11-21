import 'package:equatable/equatable.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';

abstract class MenuState extends Equatable {}

class MenuInitialState extends MenuState {
  @override
  List<Object> get props => [];
}

class MenuLoadingState extends MenuState {
  @override
  List<Object> get props => [];
}

class MenuLoadedState extends MenuState {
  MenuLoadedState(this.data, this.cart);
  final List<MenuItem> data;
  final List<MenuItem> cart;

  @override
  List<Object> get props => [data, cart];
}

class MenuErrorState extends MenuState {
  @override
  List<Object> get props => [];
}

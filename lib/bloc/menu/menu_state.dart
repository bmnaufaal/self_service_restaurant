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
  MenuLoadedState(this.data);
  final List<MenuItem> data;

  @override
  List<Object> get props => [data];
}

class MenuErrorState extends MenuState {
  @override
  List<Object> get props => [];
}

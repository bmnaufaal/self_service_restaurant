import 'package:equatable/equatable.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';

abstract class DetailState extends Equatable {}

class DetailInitialState extends DetailState {
  @override
  List<Object> get props => [];
}

class DetailLoadingState extends DetailState {
  @override
  List<Object> get props => [];
}

class DetailLoadedState extends DetailState {
  DetailLoadedState(this.data);
  final MenuItem data;

  @override
  List<Object> get props => [data];
}

class DetailErrorState extends DetailState {
  @override
  List<Object> get props => [];
}

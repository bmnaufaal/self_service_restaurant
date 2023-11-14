import 'package:equatable/equatable.dart';

abstract class CategoriesState extends Equatable {}

class CategoriesInitialState extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoadingState extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoadedState extends CategoriesState {
  CategoriesLoadedState(
    this.isSemuaActive,
    this.isNasiActive,
    this.isMieActive,
    this.isSayuranActive,
    this.isMakananRinganActive,
    this.isMakananPenutupActive,
    this.isMinumanActive,
  );

  final bool isSemuaActive;
  final bool isNasiActive;
  final bool isMieActive;
  final bool isSayuranActive;
  final bool isMakananRinganActive;
  final bool isMakananPenutupActive;
  final bool isMinumanActive;

  @override
  List<Object> get props => [
        isSemuaActive,
        isNasiActive,
        isMieActive,
        isSayuranActive,
        isMakananRinganActive,
        isMakananPenutupActive,
        isMinumanActive,
      ];
}

class CategoriesErrorState extends CategoriesState {
  @override
  List<Object> get props => [];
}

import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitialState()) {
    on<ChangeStatus>((event, emit) async {
      emit(CategoriesLoadingState());
      try {
        switch (event.selectedCategory) {
          case 'SEMUA':
            emit(CategoriesLoadedState(
              true,
              false,
              false,
              false,
              false,
              false,
              false,
            ));
            break;
          case 'NASI':
            emit(CategoriesLoadedState(
              false,
              true,
              false,
              false,
              false,
              false,
              false,
            ));
            break;
          case 'MIE':
            emit(CategoriesLoadedState(
              false,
              false,
              true,
              false,
              false,
              false,
              false,
            ));
            break;
          case 'SAYURAN':
            emit(CategoriesLoadedState(
              false,
              false,
              false,
              true,
              false,
              false,
              false,
            ));
            break;
          case 'MAKANAN RINGAN':
            emit(CategoriesLoadedState(
              false,
              false,
              false,
              false,
              true,
              false,
              false,
            ));
            break;
          case 'MAKANAN PENUTUP':
            emit(CategoriesLoadedState(
              false,
              false,
              false,
              false,
              false,
              true,
              false,
            ));
            break;
          case 'MINUMAN':
            emit(CategoriesLoadedState(
              false,
              false,
              false,
              false,
              false,
              false,
              true,
            ));
            break;
          default:
            break;
        }
      } catch (error) {
        emit(CategoriesErrorState());
      }
    });
  }
}

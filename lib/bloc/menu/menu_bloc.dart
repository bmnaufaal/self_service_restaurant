import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_state.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_event.dart';
import 'package:lunapos_akpsi/constants/dummy_menu.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitialState()) {
    on<GetMenuItem>((event, emit) async {
      try {
        emit(MenuLoadingState());
        final List<dynamic> dummy = dummyData;
        List<MenuItem> menuData = [];
        for (final data in dummy) {
          menuData.add(MenuItem.fromJson(data));
        }
        emit(MenuLoadedState(menuData));
      } catch (error) {
        emit(MenuErrorState());
      }
    });

    on<SearchItem>((event, emit) async {
      try {
        emit(MenuLoadingState());
        final List<dynamic> dummy = dummyData;
        List<MenuItem> menuData = [];
        for (final data in dummy) {
          if (data['name'] == event.search) {
            menuData.add(MenuItem.fromJson(data));
          }
        }
        emit(MenuLoadedState(menuData));
      } catch (error) {
        emit(MenuErrorState());
      }
    });

    on<SelectCategoryItem>((event, emit) async {
      try {
        emit(MenuLoadingState());
        final List<dynamic> dummy = dummyData;
        List<MenuItem> menuData = [];
        for (final data in dummy) {
          if (data['category'] == event.category) {
            menuData.add(MenuItem.fromJson(data));
          }
        }
        emit(MenuLoadedState(menuData));
      } catch (error) {
        emit(MenuErrorState());
      }
    });
  }
}

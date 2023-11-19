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
          if (event.search != '') {
            if (data['name']
                .toString()
                .toLowerCase()
                .contains(event.search.toLowerCase())) {
              menuData.add(MenuItem.fromJson(data));
            }
          } else {
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

    on<AddCountItem>((event, emit) async {
      try {
        emit(MenuLoadingState());
        List<MenuItem> menuData = List.from(event.list);

        for (int i = 0; i < menuData.length; i++) {
          final data = menuData[i];

          if (event.name == data.name) {
            int newCount = data.count + 1;

            menuData[i] = MenuItem(
              name: data.name,
              price: data.price,
              category: data.category,
              description: data.description,
              image: data.image,
              count: newCount,
            );
          }
        }
        emit(MenuLoadedState(menuData));
      } catch (error) {
        emit(MenuErrorState());
      }
    });

    on<RemoveCountItem>((event, emit) async {
      try {
        emit(MenuLoadingState());
        List<MenuItem> menuData = List.from(event.list);

        for (int i = 0; i < menuData.length; i++) {
          final data = menuData[i];

          if (event.name == data.name) {
            int newCount = data.count - 1;
            if (newCount <= 0) {
              newCount = 0;
            }

            menuData[i] = MenuItem(
              name: data.name,
              price: data.price,
              category: data.category,
              description: data.description,
              image: data.image,
              count: newCount,
            );
          }
        }
        emit(MenuLoadedState(menuData));
      } catch (error) {
        emit(MenuErrorState());
      }
    });
  }
}

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
        List<MenuItem> cart = event.cart;
        for (final data in dummy) {
          menuData.add(MenuItem.fromJson(data));
        }
        emit(MenuLoadedState(menuData, cart));
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
        emit(MenuLoadedState(menuData, event.cart));
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

        emit(MenuLoadedState(menuData, event.cart));
      } catch (error) {
        emit(MenuErrorState());
      }
    });

    on<AddCountItem>((event, emit) async {
      try {
        emit(MenuLoadingState());
        List<MenuItem> menuData = List.from(event.list);

        int itemIndex =
            menuData.indexWhere((menuItem) => menuItem.name == event.name);

        if (itemIndex != -1) {
          final data = menuData[itemIndex];
          int newCount = data.count + 1;

          menuData[itemIndex] = MenuItem(
            name: data.name,
            price: data.price,
            memberPrice: data.memberPrice,
            category: data.category,
            description: data.description,
            image: data.image,
            count: newCount,
            tag: data.tag,
          );
        } else {
          menuData.add(MenuItem(
            name: event.name,
            price: menuData[itemIndex].price,
            memberPrice: menuData[itemIndex].memberPrice,
            category: menuData[itemIndex].category,
            description: menuData[itemIndex].description,
            image: menuData[itemIndex].image,
            count: 1,
            tag: menuData[itemIndex].tag,
          ));
        }

        List<MenuItem> cart = List.from(event.cart ?? []);

        int cartIndex =
            cart.indexWhere((cartItem) => cartItem.name == event.name);

        if (cartIndex != -1) {
          cart[cartIndex] = MenuItem(
            name: event.name,
            price: menuData[itemIndex].price,
            memberPrice: menuData[itemIndex].memberPrice,
            category: menuData[itemIndex].category,
            description: menuData[itemIndex].description,
            image: menuData[itemIndex].image,
            count: cart[cartIndex].count + 1,
            tag: menuData[itemIndex].tag,
          );
        } else {
          cart.add(MenuItem(
            name: menuData[itemIndex].name,
            price: menuData[itemIndex].price,
            memberPrice: menuData[itemIndex].memberPrice,
            category: menuData[itemIndex].category,
            description: menuData[itemIndex].description,
            image: menuData[itemIndex].image,
            count: 1,
            tag: menuData[itemIndex].tag,
          ));
        }

        emit(MenuLoadedState(menuData, cart));
      } catch (error) {
        emit(MenuErrorState());
      }
    });

    on<RemoveCountItem>((event, emit) async {
      try {
        emit(MenuLoadingState());
        List<MenuItem> menuData = List.from(event.list);

        int itemIndex =
            menuData.indexWhere((menuItem) => menuItem.name == event.name);

        if (itemIndex != -1) {
          final data = menuData[itemIndex];

          if (data.count >= 0) {
            int newCount = data.count - 1;
            if (newCount < 0) {
              newCount = 0;
            }

            menuData[itemIndex] = MenuItem(
              name: data.name,
              price: data.price,
              memberPrice: data.memberPrice,
              category: data.category,
              description: data.description,
              image: data.image,
              count: newCount,
              tag: data.tag,
            );

            int cartIndex = event.cart
                .indexWhere((cartItem) => cartItem.name == event.name);

            if (cartIndex != -1) {
              if (event.cart[cartIndex].count > 1) {
                event.cart[cartIndex] = MenuItem(
                  name: event.name,
                  price: data.price,
                  memberPrice: data.memberPrice,
                  category: data.category,
                  description: data.description,
                  image: data.image,
                  count: event.cart[cartIndex].count - 1,
                  tag: data.tag,
                );
              } else {
                event.cart.removeAt(cartIndex);
              }
            }
          }
        }

        emit(MenuLoadedState(menuData, event.cart));
      } catch (error) {
        emit(MenuErrorState());
      }
    });
  }
}

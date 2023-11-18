import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/cart/cart_event.dart';
import 'package:lunapos_akpsi/bloc/cart/cart_state.dart';
import 'package:lunapos_akpsi/constants/dummy_menu.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<AddCartItem>((event, emit) async {
      try {
        emit(CartLoadingState());
        final List<dynamic> dummy = dummyData;
        List<MenuItem> cart = event.cart;
        for (final data in dummy) {
          if (data['name']
              .toString()
              .toLowerCase()
              .contains(event.name.toLowerCase())) {
            cart.add(MenuItem.fromJson(data));
          }
        }

        emit(CartLoadedState(cart));
      } catch (error) {
        emit(CartErrorState());
      }
    });

    on<RemoveCartItem>((event, emit) async {
      try {
        emit(CartLoadingState());
        final List<dynamic> dummy = dummyData;
        List<MenuItem> cart = event.cart;
        for (final data in dummy) {
          if (data['name']
              .toString()
              .toLowerCase()
              .contains(event.name.toLowerCase())) {
            cart.remove(MenuItem.fromJson(data));
          }
        }

        emit(CartLoadedState(cart));
      } catch (error) {
        emit(CartErrorState());
      }
    });
  }
}

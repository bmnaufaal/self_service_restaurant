import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/cart/cart_event.dart';
import 'package:lunapos_akpsi/bloc/cart/cart_state.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<AddCountCart>((event, emit) async {
      try {
        emit(CartLoadingState());
        List<MenuItem> cart = List.from(event.cart);
        for (int i = 0; i < cart.length; i++) {
          final data = cart[i];

          if (event.name == data.name) {
            int newCount = data.count + 1;

            cart[i] = MenuItem(
              name: data.name,
              price: data.price,
              category: data.category,
              description: data.description,
              image: data.image,
              count: newCount,
            );
          }
        }
        emit(CartLoadedState(cart));
      } catch (error) {
        emit(CartErrorState());
      }
    });

    on<RemoveCountCart>((event, emit) async {
      try {
        emit(CartLoadingState());
        List<MenuItem> cart = List.from(event.cart);

        for (int i = 0; i < cart.length; i++) {
          final data = cart[i];

          if (event.name == data.name) {
            int newCount = data.count - 1;

            if (newCount > 0) {
              cart[i] = MenuItem(
                name: data.name,
                price: data.price,
                category: data.category,
                description: data.description,
                image: data.image,
                count: newCount,
              );
            } else {
              cart.removeAt(i);
            }
          }
        }

        emit(CartLoadedState(cart));
      } catch (error) {
        emit(CartErrorState());
      }
    });

    on<DeleteItemCart>((event, emit) async {
      try {
        emit(CartLoadingState());
        List<MenuItem> cart = List.from(event.cart);

        for (int i = 0; i < cart.length; i++) {
          final data = cart[i];

          if (event.name == data.name) {
            cart.removeAt(i);
          }
        }

        emit(CartLoadedState(cart));
      } catch (error) {
        emit(CartErrorState());
      }
    });
  }
}

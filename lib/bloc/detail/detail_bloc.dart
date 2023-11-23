// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/detail/detail_event.dart';
import 'package:lunapos_akpsi/bloc/detail/detail_state.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitialState()) {
    on<GetDetailItem>((event, emit) async {
      try {
        emit(DetailLoadingState());
        final List<MenuItem> list = event.list;
        MenuItem? detail;

        for (final data in list) {
          if (event.name == data.name) {
            detail = MenuItem(
              name: data.name,
              price: data.price,
              memberPrice: data.memberPrice,
              category: data.category,
              description: data.description,
              image: data.image,
              count: data.count,
              tag: data.tag,
            );
            break;
          }
        }

        if (detail != null) {
          emit(DetailLoadedState(detail));
        } else {
          throw ("Data is not found");
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        emit(DetailErrorState());
      }
    });

    on<AddCountDetailItem>((event, emit) async {
      try {
        emit(DetailLoadingState());
        MenuItem detail = event.item.copyWith(count: event.item.count + 1);
        emit(DetailLoadedState(detail));
      } catch (error) {
        emit(DetailErrorState());
      }
    });

    on<RemoveCountDetailItem>((event, emit) async {
      try {
        emit(DetailLoadingState());
        MenuItem detail = event.item.copyWith(count: event.item.count - 1);
        emit(DetailLoadedState(detail));
      } catch (error) {
        emit(DetailErrorState());
      }
    });
  }
}

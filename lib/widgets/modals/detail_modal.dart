import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/bloc/detail/detail_event.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';

import '../../bloc/detail/detail_bloc.dart';
import '../../bloc/detail/detail_state.dart';

class DetailModal extends StatefulWidget {
  const DetailModal({
    super.key,
    required this.list,
    required this.title,
    required this.onAdd,
    required this.onRemove,
  });

  final List<MenuItem> list;
  final String title;
  final dynamic onAdd;
  final dynamic onRemove;

  @override
  State<DetailModal> createState() => _DetailModalState();
}

class _DetailModalState extends State<DetailModal> {
  @override
  Widget build(BuildContext context) {
    int price = 0;
    String image = '';
    String description = '';
    int count = 0;

    return BlocProvider<DetailBloc>(
      create: (context) {
        final DetailBloc bloc = DetailBloc();
        bloc.add(GetDetailItem(widget.list, widget.title));
        return bloc;
      },
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailLoadedState) {
            price = state.data.price;
            image = state.data.image;
            description = state.data.description;
            count = state.data.count;

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/$image',
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                          .format(price),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      description,
                      textAlign: TextAlign.justify,
                    ),
                    const Spacer(),
                    if (count != 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              widget.onRemove();
                              BlocProvider.of<DetailBloc>(context).add(
                                RemoveCountDetailItem(state.data),
                              );
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text(count.toString()),
                          IconButton(
                            onPressed: () {
                              widget.onAdd();
                              BlocProvider.of<DetailBloc>(context).add(
                                AddCountDetailItem(state.data),
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    if (count == 0)
                      PrimaryButton(
                        title: 'Tambah ke Pesanan',
                        icon: Icons.add,
                        maxWidth: true,
                        onPressed: () {
                          widget.onAdd();
                          BlocProvider.of<DetailBloc>(context).add(
                            AddCountDetailItem(state.data),
                          );
                        },
                      ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          }

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

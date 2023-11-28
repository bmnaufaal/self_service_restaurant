import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/bloc/detail/detail_event.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/detail/detail_bloc.dart';
import '../../bloc/detail/detail_state.dart';

class DetailModal extends StatefulWidget {
  const DetailModal({
    super.key,
    required this.list,
    required this.title,
    required this.onAdd,
    required this.onRemove,
    required this.isLoggedIn,
  });

  final List<MenuItem> list;
  final String title;
  final dynamic onAdd;
  final dynamic onRemove;
  final bool isLoggedIn;

  @override
  State<DetailModal> createState() => _DetailModalState();
}

class _DetailModalState extends State<DetailModal> {
  bool checkDiscount(int price, int memberPrice) {
    if (widget.isLoggedIn == true) {
      if (price != memberPrice) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    String tag = '';
    int price = 0;
    int? memberPrice;
    String image = '';
    String description = '';
    int count = 0;
    bool isDiscounted = false;

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
            tag = state.data.tag;
            memberPrice = state.data.memberPrice;
            image = state.data.image;
            description = state.data.description;
            count = state.data.count;
            isDiscounted = checkDiscount(price, memberPrice!);

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
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
                    Row(
                      children: [
                        Text(
                          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                              .format(price),
                          style: TextStyle(
                            fontSize: 18,
                            color: (isDiscounted == true)
                                ? Colors.red
                                : Colors.black,
                            decoration: isDiscounted == true
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        const Spacer(),
                        PrimaryButton(
                          title: tag,
                          customColor: Colors.green,
                          onPressed: () {},
                          icon: Icons.sell,
                        )
                      ],
                    ),
                    if (isDiscounted == true)
                      Text(
                        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                            .format(memberPrice),
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
                        title: AppLocalizations.of(context)!.addToCart,
                        icon: Icons.add,
                        maxWidth: true,
                        onPressed: () {
                          widget.onAdd();
                          BlocProvider.of<DetailBloc>(context).add(
                            AddCountDetailItem(state.data),
                          );
                        },
                      ),
                    const SizedBox(height: 16),
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

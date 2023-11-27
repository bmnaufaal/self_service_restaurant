import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/modals/detail_modal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemCard extends StatefulWidget {
  ItemCard({
    super.key,
    required this.title,
    required this.price,
    this.memberPrice,
    required this.image,
    required this.description,
    required this.order,
    required this.count,
    required this.onAdd,
    required this.onRemove,
    required this.list,
    required this.isLoggedIn,
  });

  final String title;
  final int price;
  int? memberPrice;
  final String image;
  final String description;
  final dynamic order;
  final int count;
  final dynamic onAdd;
  final dynamic onRemove;
  final List<MenuItem> list;
  final bool isLoggedIn;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  void initState() {
    super.initState();
  }

  bool isDiscounted() {
    if (widget.isLoggedIn == true) {
      if (widget.price != widget.memberPrice) {
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
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          elevation: 0,
          showDragHandle: true,
          builder: (_) {
            return Builder(builder: (BuildContext context) {
              return DetailModal(
                title: widget.title,
                onAdd: () {
                  widget.onAdd(widget.title);
                },
                onRemove: () {
                  widget.onRemove(widget.title);
                },
                list: widget.list,
                isLoggedIn: widget.isLoggedIn,
              );
            });
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/${widget.image}'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                    .format(widget.price),
                style: TextStyle(
                  color: isDiscounted() == true ? Colors.red : Colors.black,
                  decoration: isDiscounted() == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            if (widget.isLoggedIn == true &&
                isDiscounted() == true &&
                widget.memberPrice != null)
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                        .format(widget.memberPrice ?? 0),
                  )),
            const Spacer(),
            if (widget.count != 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      widget.onRemove(widget.title);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(widget.count.toString()),
                  IconButton(
                    onPressed: () {
                      widget.onAdd(widget.title);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            if (widget.count == 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PrimaryButton(
                  title: AppLocalizations.of(context)!.order,
                  icon: Icons.add,
                  maxWidth: true,
                  onPressed: () {
                    widget.order(widget.title);
                  },
                ),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

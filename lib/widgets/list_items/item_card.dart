import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/modals/detail_modal.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
  });

  final String title;
  final int price;
  final String image;
  final String description;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
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
            return DetailModal(
              title: widget.title,
              price: widget.price,
              image: widget.image,
              description: widget.description,
            );
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
            Image.asset(
              'assets/images/${widget.image}',
              // width: double.infinity,
              width: double.infinity,
              height: 150,
              fit: BoxFit.fill,
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
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PrimaryButton(
                title: 'Pesan',
                icon: Icons.add,
                maxWidth: true,
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

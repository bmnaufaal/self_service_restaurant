import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
  });

  final String title;
  final int price;
  final String image;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            fit: BoxFit.scaleDown,
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
            child: Text('Rp${widget.price}'),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PrimaryButton(
              title: 'Pesan',
              icon: Icons.add,
              maxWidth: true,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

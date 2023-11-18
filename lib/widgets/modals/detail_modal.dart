import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';

class DetailModal extends StatefulWidget {
  const DetailModal({
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
  State<DetailModal> createState() => _DetailModalState();
}

class _DetailModalState extends State<DetailModal> {
  @override
  Widget build(BuildContext context) {
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
                'assets/images/${widget.image}',
                height: 300,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                  .format(widget.price),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.description,
              textAlign: TextAlign.justify,
            ),
            const Spacer(),
            PrimaryButton(
              title: 'Tambah ke Pesanan',
              icon: Icons.add,
              maxWidth: true,
              onPressed: () {},
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

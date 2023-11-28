import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutButton extends StatefulWidget {
  const CheckoutButton({
    super.key,
    required this.itemCount,
    required this.totalPrice,
    required this.onPressed,
    required this.icon,
  });

  final int itemCount;
  final int totalPrice;
  final dynamic onPressed;
  final IconData icon;

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF53387D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: widget.onPressed,
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        titleTextStyle: const TextStyle(color: Colors.white),
        leadingAndTrailingTextStyle: const TextStyle(color: Colors.white),
        leading: Icon(
          widget.icon,
          color: Colors.white,
        ),
        title:
            Text('${widget.itemCount} ${AppLocalizations.of(context)!.item}'),
        trailing: Text(
          NumberFormat.currency(
            locale: 'id_ID',
            symbol: 'Rp',
          ).format(widget.totalPrice),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

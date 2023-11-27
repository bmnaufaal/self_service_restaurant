import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/screens/cashier_payment_screen.dart';
import 'package:lunapos_akpsi/screens/online_payment_screen.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';

class PaymentModal extends StatefulWidget {
  const PaymentModal({
    super.key,
    required this.isLoggedIn,
    required this.totalPrice,
  });

  final bool isLoggedIn;
  final int totalPrice;

  @override
  State<PaymentModal> createState() => _PaymentModalState();
}

class _PaymentModalState extends State<PaymentModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 300,
              child: PrimaryButton(
                title: 'Pembayaran Online',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => OnlinePaymentScreen(
                        isLoggedIn: widget.isLoggedIn,
                        totalPrice: widget.totalPrice,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 300,
              child: PrimaryButton(
                title: 'Pembayaran di kasir',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const CashierPaymentScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

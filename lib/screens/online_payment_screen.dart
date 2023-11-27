import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/screens/cashier_payment_screen.dart';
import 'package:lunapos_akpsi/screens/home_screen.dart';
import 'package:lunapos_akpsi/screens/payment_failed.dart';
import 'package:lunapos_akpsi/screens/payment_success.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';

class OnlinePaymentScreen extends StatefulWidget {
  const OnlinePaymentScreen({
    super.key,
    required this.isLoggedIn,
    required this.totalPrice,
  });

  final bool isLoggedIn;
  final int totalPrice;

  @override
  State<OnlinePaymentScreen> createState() => _OnlinePaymentScreenState();
}

class _OnlinePaymentScreenState extends State<OnlinePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Total',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
            Text(
              NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(
                widget.totalPrice,
              ),
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const PaymentFailedScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                color: Colors.indigo[100],
                child: Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.white,
                  child: const Icon(
                    Icons.qr_code_2,
                    size: 250,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 300,
              child: PrimaryButton(
                title: 'Download QRIS',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => PaymentSuccessScreen(
                        isMember: widget.isLoggedIn,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 300,
              child: PrimaryButton(
                title: 'Cashier Payment',
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
import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/screens/home_screen.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({
    super.key,
    required this.isMember,
  });

  final bool? isMember;

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 175,
              height: 175,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.verified_rounded,
                  size: 150,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Payment Success',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
            const Text(
              'No. 0000-1',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 32),
            if (widget.isMember == true)
              const Text(
                'You Got 10 Loyalty Points',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            if (widget.isMember == true) const SizedBox(height: 15),
            SizedBox(
              width: 300,
              child: PrimaryButton(
                title: 'Done',
                onPressed: () {
                  Navigator.of(context).popUntil(
                    (route) => route.isFirst,
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomeScreen(),
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

import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/screens/home_screen.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CashierPaymentScreen extends StatefulWidget {
  CashierPaymentScreen({
    super.key,
    required this.onChangeLanguage,
  });

  dynamic? onChangeLanguage;

  @override
  State<CashierPaymentScreen> createState() => _CashierPaymentScreenState();
}

class _CashierPaymentScreenState extends State<CashierPaymentScreen> {
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
            Text(
              AppLocalizations.of(context)!.orderCreated,
              style: const TextStyle(
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
            SizedBox(
              width: 300,
              child: PrimaryButton(
                title: AppLocalizations.of(context)!.finish,
                onPressed: () {
                  Navigator.of(context).popUntil(
                    (route) => route.isFirst,
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeScreen(
                        onChangeLanguage: widget.onChangeLanguage,
                      ),
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

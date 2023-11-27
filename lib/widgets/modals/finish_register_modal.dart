import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/widgets/alerts/success_alert.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FinishRegisterModal extends StatefulWidget {
  const FinishRegisterModal({super.key});

  @override
  State<FinishRegisterModal> createState() => _FinishRegisterModalState();
}

class _FinishRegisterModalState extends State<FinishRegisterModal> {
  final validOTP = '170845';
  final registeredPhoneNumber = '081234567890';

  final Map<String, TextEditingController> controller = {
    'userName': TextEditingController(),
  };

  @override
  void dispose() {
    for (var controller in controller.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.register,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              color: Color(0xFF53387D),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                AppLocalizations.of(context)!.userName,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            FormInput(
              hintText: '',
              controller: controller['userName']!,
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                maxWidth: true,
                title: AppLocalizations.of(context)!.submit,
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const SuccessAlert(
                        message: 'Success Register',
                      );
                    },
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

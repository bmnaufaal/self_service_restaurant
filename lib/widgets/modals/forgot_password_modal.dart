import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';
import 'package:lunapos_akpsi/widgets/modals/register_modal.dart';

class ForgotPasswordModal extends StatefulWidget {
  const ForgotPasswordModal({
    super.key,
    required this.onPressed,
  });

  final dynamic onPressed;

  @override
  State<ForgotPasswordModal> createState() => _ForgotPasswordModalState();
}

class _ForgotPasswordModalState extends State<ForgotPasswordModal> {
  final validOTP = '170845';
  final registeredPhoneNumber = '081234567890';

  final Map<String, TextEditingController> controller = {
    'phoneNumber': TextEditingController(),
    'password': TextEditingController(),
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
      title: const Text(
        'Forgot Password',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          color: Color(0xFF53387D),
        ),
      ),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            FormInput(
              hintText: '',
              controller: controller['phoneNumber']!,
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              maxWidth: true,
              title: 'Send Reset Password',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

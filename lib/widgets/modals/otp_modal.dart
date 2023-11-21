import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';

class OTPModal extends StatefulWidget {
  const OTPModal({
    super.key,
    required this.onPressed,
  });

  final dynamic onPressed;

  @override
  State<OTPModal> createState() => _OTPModalState();
}

class _OTPModalState extends State<OTPModal> {
  final Map<String, TextEditingController> controller = {
    'otp': TextEditingController(),
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
        'OTP',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 36,
          color: Color(0xFF53387D),
        ),
      ),
      content: SizedBox(
        width: 300,
        child: Row(
          children: [
            Expanded(
              child: FormInput(
                hintText: '',
                isPassword: true,
                controller: controller['otp']!,
                validator: (value) {
                  return null;
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FormInput(
                hintText: '',
                isPassword: true,
                controller: controller['otp']!,
                validator: (value) {
                  return null;
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FormInput(
                hintText: '',
                isPassword: true,
                controller: controller['otp']!,
                validator: (value) {
                  return null;
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FormInput(
                hintText: '',
                isPassword: true,
                controller: controller['otp']!,
                validator: (value) {
                  return null;
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FormInput(
                hintText: '',
                isPassword: true,
                controller: controller['otp']!,
                validator: (value) {
                  return null;
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FormInput(
                hintText: '',
                isPassword: true,
                controller: controller['otp']!,
                validator: (value) {
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        PrimaryButton(
          title: 'Submit',
          onPressed: () {},
        )
      ],
    );
  }
}

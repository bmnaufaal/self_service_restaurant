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
    'first': TextEditingController(),
    'second': TextEditingController(),
    'third': TextEditingController(),
    'forth': TextEditingController(),
    'fifth': TextEditingController(),
    'sixth': TextEditingController(),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      actionsPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      content: SizedBox(
        width: 300,
        child: Row(
          children: [
            Expanded(
              child: FormInput(
                hintText: '',
                isPassword: true,
                controller: controller['first']!,
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
                controller: controller['second']!,
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
                controller: controller['third']!,
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
                controller: controller['forth']!,
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
                controller: controller['fifth']!,
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
                controller: controller['sixth']!,
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
          onPressed: () {
            String otpValue = '';
            controller.forEach((key, value) {
              otpValue += value.text;
            });
            widget.onPressed(otpValue);
          },
        )
      ],
    );
  }
}

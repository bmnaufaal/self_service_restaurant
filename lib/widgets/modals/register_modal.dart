import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';

class RegisterModal extends StatefulWidget {
  const RegisterModal({
    super.key,
    required this.onPressed,
  });

  final dynamic onPressed;

  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  final Map<String, TextEditingController> controller = {
    'username': TextEditingController(),
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
        'Register',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 36,
          color: Color(0xFF53387D),
        ),
      ),
      content: Container(
        padding: const EdgeInsets.all(8),
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
              controller: controller['username']!,
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            FormInput(
              hintText: '',
              isPassword: true,
              controller: controller['password']!,
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              onPressed: () {
                widget.onPressed();
              },
              maxWidth: true,
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}

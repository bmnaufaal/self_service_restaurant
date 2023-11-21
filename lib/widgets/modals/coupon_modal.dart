import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';

class CouponModal extends StatefulWidget {
  const CouponModal({
    super.key,
    required this.onPressed,
  });

  final dynamic onPressed;

  @override
  State<CouponModal> createState() => _CouponModalState();
}

class _CouponModalState extends State<CouponModal> {
  final Map<String, TextEditingController> controller = {
    'coupon': TextEditingController(),
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
        'Coupon',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 36,
          color: Color(0xFF53387D),
        ),
      ),
      content: FormInput(
        hintText: 'Enter coupon code',
        controller: controller['coupon']!,
        validator: (value) {
          return null;
        },
      ),
      actions: [
        PrimaryButton(
          title: 'Submit',
          onPressed: () {
            Navigator.of(context).pop();
            widget.onPressed(controller['coupon']?.text);
          },
        )
      ],
    );
  }
}

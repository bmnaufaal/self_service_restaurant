import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/coupon/coupon_bloc.dart';
import 'package:lunapos_akpsi/bloc/coupon/coupon_event.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';

class CouponModal extends StatefulWidget {
  const CouponModal({super.key});

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
        uppercaseOnly: true,
        validator: (value) {
          return null;
        },
      ),
      actions: [
        PrimaryButton(
          title: 'Submit',
          onPressed: () {
            BlocProvider.of<CouponBloc>(context).add(
              PostCoupon(controller['coupon']!.text),
            );
          },
        )
      ],
    );
  }
}

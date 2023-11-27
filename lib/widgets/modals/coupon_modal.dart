import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/coupon/coupon_bloc.dart';
import 'package:lunapos_akpsi/bloc/coupon/coupon_event.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.coupon,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 36,
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
      content: FormInput(
        hintText: AppLocalizations.of(context)!.enterCouponCode,
        controller: controller['coupon']!,
        uppercaseOnly: true,
        validator: (value) {
          return null;
        },
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            title: AppLocalizations.of(context)!.submit,
            onPressed: () {
              BlocProvider.of<CouponBloc>(context).add(
                PostCoupon(controller['coupon']!.text),
              );
            },
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/otp/otp_bloc.dart';
import 'package:lunapos_akpsi/bloc/otp/otp_event.dart';
import 'package:lunapos_akpsi/bloc/otp/otp_state.dart';
import 'package:lunapos_akpsi/widgets/alerts/error_alert.dart';
import 'package:lunapos_akpsi/widgets/alerts/success_alert.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';

class OTPModal extends StatefulWidget {
  const OTPModal({super.key});

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
    return BlocConsumer<OTPBloc, OTPState>(
      listener: (context, state) {
        if (state is OTPLoadedState) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) {
              return const SuccessAlert(
                message: 'You have been successfully registered',
              );
            },
          );
        }
        
        if (state is OTPErrorState) {
          showDialog(
            context: context,
            builder: (context) {
              return ErrorAlert(
                message: state.error,
              );
            },
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text(
            'OTP',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              color: Color(0xFF53387D),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
                BlocProvider.of<OTPBloc>(context).add(PostOTP(otpValue));
              },
            )
          ],
        );
      },
    );
  }
}

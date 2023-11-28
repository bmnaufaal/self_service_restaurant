import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/otp/otp_bloc.dart';
import 'package:lunapos_akpsi/bloc/otp/otp_event.dart';
import 'package:lunapos_akpsi/bloc/otp/otp_state.dart';
import 'package:lunapos_akpsi/widgets/alerts/error_alert.dart';
import 'package:lunapos_akpsi/widgets/alerts/success_alert.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';
import 'package:lunapos_akpsi/widgets/modals/finish_register_modal.dart';

class OTPModal extends StatefulWidget {
  const OTPModal({Key? key}) : super(key: key);

  @override
  State<OTPModal> createState() => _OTPModalState();
}

class _OTPModalState extends State<OTPModal> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      6,
      (index) => TextEditingController(),
    );
    focusNodes = List.generate(
      6,
      (index) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
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
              return const FinishRegisterModal();
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'OTP',
                textAlign: TextAlign.center,
                style: TextStyle(
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          content: SizedBox(
            width: 300,
            child: Row(
              children: List.generate(
                6,
                (index) => Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: FormInput(
                      hintText: '',
                      isPassword: true,
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      onChanged: (value) {
                        if (value.length == 1 && index < 5) {
                          focusNodes[index + 1].requestFocus();
                        }
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            PrimaryButton(
              title: 'Kirim',
              onPressed: () {
                String otpValue = '';
                controllers.forEach((controller) {
                  otpValue += controller.text;
                });
                print(otpValue);
                BlocProvider.of<OTPBloc>(context).add(PostOTP(otpValue));
              },
            )
          ],
        );
      },
    );
  }
}

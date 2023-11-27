import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:lunapos_akpsi/bloc/forgot_password/forgot_password_event.dart';
import 'package:lunapos_akpsi/bloc/forgot_password/forgot_password_state.dart';
import 'package:lunapos_akpsi/widgets/alerts/error_alert.dart';
import 'package:lunapos_akpsi/widgets/alerts/success_alert.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';

class ForgotPasswordModal extends StatefulWidget {
  const ForgotPasswordModal({super.key});

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
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordLoadedState) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) {
              return const SuccessAlert(
                message: 'We have sent password reset link',
              );
            },
          );
        }

        if (state is ForgotPasswordErrorState) {
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
            'Lupa Password',
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
                    'Nomor Telepon',
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
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    maxWidth: true,
                    title: 'Kirim',
                    onPressed: () {
                      BlocProvider.of<ForgotPasswordBloc>(context).add(
                        PostForgotPassword(
                          controller['phoneNumber']!.text,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

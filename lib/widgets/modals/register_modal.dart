import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/register/register_bloc.dart';
import 'package:lunapos_akpsi/bloc/register/register_event.dart';
import 'package:lunapos_akpsi/bloc/register/register_state.dart';
import 'package:lunapos_akpsi/widgets/alerts/error_alert.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';
import 'package:lunapos_akpsi/widgets/modals/otp_modal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterModal extends StatefulWidget {
  const RegisterModal({super.key});

  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
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
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadedState) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) {
              return const OTPModal();
            },
          );
        }

        if (state is RegisterErrorState) {
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
              Text(
                AppLocalizations.of(context)!.register,
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
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    AppLocalizations.of(context)!.phoneNumber,
                    style: const TextStyle(
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
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    AppLocalizations.of(context)!.password,
                    style: const TextStyle(
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
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    onPressed: () {
                      BlocProvider.of<RegisterBloc>(context).add(
                        PostRegister(controller),
                      );
                    },
                    maxWidth: true,
                    title: AppLocalizations.of(context)!.register,
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

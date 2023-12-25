import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/login/login_bloc.dart';
import 'package:lunapos_akpsi/bloc/login/login_event.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';
import 'package:lunapos_akpsi/widgets/modals/forgot_password_modal.dart';
import 'package:lunapos_akpsi/widgets/modals/register_modal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
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
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.login,
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
              isNumberOnly: true,
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
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const ForgotPasswordModal();
                      });
                },
                child: Text(
                  AppLocalizations.of(context)!.forgotPassword,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context)
                      .add(PostLogin(controller));
                },
                maxWidth: true,
                title: AppLocalizations.of(context)!.login,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const RegisterModal();
                    },
                  );
                },
                child: Text(AppLocalizations.of(context)!.register),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

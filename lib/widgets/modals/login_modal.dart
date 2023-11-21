import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/widgets/alerts/error_alert.dart';
import 'package:lunapos_akpsi/widgets/alerts/success_alert.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';
import 'package:lunapos_akpsi/widgets/modals/forgot_password_modal.dart';
import 'package:lunapos_akpsi/widgets/modals/otp_modal.dart';
import 'package:lunapos_akpsi/widgets/modals/register_modal.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({
    super.key,
    required this.onPressed,
  });

  final dynamic onPressed;

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
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
    return AlertDialog(
      title: const Text(
        'Login',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 36,
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
                'Phone Number',
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
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ForgotPasswordModal(
                          onPressed: () {},
                        );
                      });
                },
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 8),
            PrimaryButton(
              onPressed: () {
                widget.onPressed();
              },
              maxWidth: true,
              title: 'Login',
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
                      return RegisterModal(
                        onPressed: (String value) {
                          Navigator.of(context).pop();
                          if (value != registeredPhoneNumber) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return OTPModal(
                                  onPressed: (String value) {
                                    bool validator = (value == validOTP);
                                    if (validator == true) {
                                      Navigator.of(context).pop();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const SuccessAlert(
                                            message:
                                                'You have been successfully registered',
                                          );
                                        },
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const ErrorAlert(
                                            message: 'OTP Number is incorrect',
                                          );
                                        },
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const ErrorAlert(
                                  message: 'Phone number is already registered',
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  );
                },
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

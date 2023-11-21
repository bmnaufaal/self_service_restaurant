import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      content: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const CircleAvatar(
              radius: 80,
              backgroundColor: Colors.red,
              child: Icon(
                Icons.report,
                size: 100,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Error',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

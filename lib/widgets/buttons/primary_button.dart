import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.maxWidth,
  });

  final String title;
  final dynamic onPressed;
  IconData? icon;
  bool? maxWidth;

  @override
  Widget build(BuildContext context) {
    return (icon != null)
        ? SizedBox(
            width: maxWidth == true ? double.infinity : null,
            child: ElevatedButton.icon(
              icon: Icon(icon!, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF53387D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: onPressed,
              label: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF53387D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize:
                  maxWidth == true ? const Size(double.infinity, 50.0) : null,
            ),
            onPressed: onPressed,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
  }
}

import 'package:flutter/material.dart';

class UserButton extends StatefulWidget {
  const UserButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.icon,
  });

  final String title;
  final dynamic onPressed;
  final IconData icon;

  @override
  State<UserButton> createState() => _UserButtonState();
}

class _UserButtonState extends State<UserButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF53387D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: widget.onPressed,
      child: (widget.title != '')
          ? Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )
          : Icon(
              widget.icon,
              color: Colors.white,
            ),
    );
  }
}

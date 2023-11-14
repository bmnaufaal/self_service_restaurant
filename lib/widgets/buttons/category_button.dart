import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isActive,
  });

  final String title;
  final dynamic onPressed;
  final bool isActive;

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            widget.isActive == true ? const Color(0xFF53387D) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.title,
        style: TextStyle(
          color: widget.isActive == true
              ? const Color(0xFFA8D94A)
              : const Color(0xFF898989),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

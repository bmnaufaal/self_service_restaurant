import 'dart:io';

import 'package:flutter/material.dart';

class InviteModal extends StatefulWidget {
  const InviteModal({
    super.key,
    this.onImageClicked,
    this.onClose,
  });

  final dynamic onImageClicked;
  final dynamic onClose;

  @override
  State<InviteModal> createState() => _InviteModalState();
}

class _InviteModalState extends State<InviteModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Invite Order',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF53387D),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: widget.onClose,
          ),
        ],
      ),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: widget.onImageClicked,
              child: const Icon(
                Icons.qr_code_2,
                size: 250,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: widget.onImageClicked,
              child: const Text(
                'https://lunapos.id/RestoranA/Aj28sNwial',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

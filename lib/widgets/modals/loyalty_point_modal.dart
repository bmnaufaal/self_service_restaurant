import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';

class LoyaltyPointModal extends StatefulWidget {
  const LoyaltyPointModal({super.key});

  @override
  State<LoyaltyPointModal> createState() => _LoyaltyPointModalState();
}

class _LoyaltyPointModalState extends State<LoyaltyPointModal> {
  final Map<String, TextEditingController> controller = {
    'coupon': TextEditingController(),
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
        'Loyalty Point',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 36,
          color: Color(0xFF53387D),
        ),
      ),
      content: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Discount 5%'),
            subtitle: const Text('50 Points'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Discount 10%'),
            subtitle: const Text('50 Points'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Discount 25%'),
            subtitle: const Text('50 Points'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Discount 50%'),
            subtitle: const Text('50 Points'),
            onTap: () {},
          ),
        ],
      ),
      actions: [
        PrimaryButton(
          title: 'Use Loyalty Points',
          maxWidth: true,
          onPressed: () {},
        )
      ],
    );
  }
}

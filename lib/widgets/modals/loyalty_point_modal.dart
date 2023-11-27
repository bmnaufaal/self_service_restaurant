import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoyaltyPointModal extends StatefulWidget {
  const LoyaltyPointModal({
    Key? key,
    required this.loyaltyPoints,
    required this.onSelected,
  }) : super(key: key);

  final int loyaltyPoints;
  final Function(int, int) onSelected;

  @override
  State<LoyaltyPointModal> createState() => _LoyaltyPointModalState();
}

class _LoyaltyPointModalState extends State<LoyaltyPointModal> {
  int pointsUsed = 0;
  int discountPercent = 0;
  int selectedPoints = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        // alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryButton(
              onPressed: () {},
              icon: Icons.monetization_on,
              title:
                  '${widget.loyaltyPoints} ${AppLocalizations.of(context)!.points}',
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: buildPointsContainer(10, 5),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: buildPointsContainer(20, 10),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: buildPointsContainer(50, 25),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: buildPointsContainer(
                  100,
                  50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              title: AppLocalizations.of(context)!.useLoyaltyPoints,
              maxWidth: true,
              onPressed: () {
                Navigator.of(context).pop();
                widget.onSelected(
                  pointsUsed,
                  discountPercent,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildPointsContainer(int points, int discount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          pointsUsed = points;
          discountPercent = discount;
          selectedPoints = points;
        });
      },
      child: Container(
        color:
            selectedPoints == points ? Colors.green : const Color(0xFF53387D),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              '$points ${AppLocalizations.of(context)!.points}',
              style: TextStyle(
                color: selectedPoints == points ? Colors.white : Colors.white,
              ),
            ),
            Text(
              '${AppLocalizations.of(context)!.discount} $discount%',
              style: TextStyle(
                color: selectedPoints == points ? Colors.white : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

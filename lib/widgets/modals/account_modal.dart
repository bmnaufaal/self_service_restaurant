import 'package:flutter/material.dart';

class AccountModal extends StatefulWidget {
  const AccountModal({
    super.key,
    required this.name,
    required this.onPressed,
  });

  final String name;
  final dynamic onPressed;

  @override
  State<AccountModal> createState() => _AccountModalState();
}

class _AccountModalState extends State<AccountModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Log Out',
                style: TextStyle(
                    // fontWeight: FontWeight.w700,
                    ),
              ),
              onTap: widget.onPressed,
            ),
            const SizedBox(height: 16),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     const Text(
            //       'Languages: ',
            //       style: TextStyle(
            //           // fontWeight: FontWeight.w700,
            //           ),
            //     ),
            //     SegmentedButton(
            //       segments: const [
            //         ButtonSegment(
            //           value: Languages.id,
            //           label: Text('ID'),
            //         ),
            //         ButtonSegment(
            //           value: Languages.en,
            //           label: Text('EN'),
            //         ),
            //       ],
            //       selected: <Languages>{languages},
            //       onSelectionChanged: (Set<Languages> newSelection) {
            //         setState(() {
            //           languages = newSelection.first;
            //         });
            //       },
            //       showSelectedIcon: false,
            //       style: ButtonStyle(
            //         visualDensity: VisualDensity.compact,
            //         shape: MaterialStateProperty.all(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

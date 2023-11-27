import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';
import 'package:lunapos_akpsi/screens/home_screen.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';

class HistoryOrderScreen extends StatefulWidget {
  const HistoryOrderScreen({super.key});

  @override
  State<HistoryOrderScreen> createState() => _HistoryOrderScreenState();
}

class _HistoryOrderScreenState extends State<HistoryOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          color: const Color(0xFF53387D),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 125,
                height: 125,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/nasi_goreng.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '5 Oct 2023',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Nasi Goreng',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'x1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                    right: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 14),
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                            .format(
                          30000,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 14),
                      PrimaryButton(
                        customColor: Colors.green,
                        title: 'Reorder',
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (_) {
                            return HomeScreen(
                              isLoggedIn: true,
                              userName: 'Naufal',
                              loyaltyPoints: 50,
                              cart: [
                                MenuItem(
                                  name: 'Nasi Goreng',
                                  price: 30000,
                                  memberPrice: 28000,
                                  category: 'Nasi',
                                  description:
                                      'Nasi goreng spesial dengan campuran bumbu pilihan, sayuran segar, dan daging ayam. Rasanya lezat dan cocok untuk penggemar nasi goreng.',
                                  image: 'nasi_goreng.png',
                                  count: 1,
                                  tag: 'Spicy',
                                )
                              ],
                            );
                          }));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Card(
          color: const Color(0xFF53387D),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 125,
                height: 125,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/mie_ayam_bakso.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '22 Oct 2023',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Mie Ayam Bakso',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'x1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        '+1 other items',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                    right: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 14),
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                            .format(
                          20000,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 14),
                      PrimaryButton(
                        customColor: Colors.green,
                        title: 'Reorder',
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (_) {
                            return HomeScreen(
                              isLoggedIn: true,
                              userName: 'Naufal',
                              loyaltyPoints: 50,
                              cart: [
                                MenuItem(
                                  name: 'Nasi Goreng',
                                  price: 30000,
                                  memberPrice: 28000,
                                  category: 'Nasi',
                                  description:
                                      'Nasi goreng spesial dengan campuran bumbu pilihan, sayuran segar, dan daging ayam. Rasanya lezat dan cocok untuk penggemar nasi goreng.',
                                  image: 'nasi_goreng.png',
                                  count: 1,
                                  tag: 'Spicy',
                                ),
                                MenuItem(
                                  name: 'Mie Ayam Bakso',
                                  price: 20000,
                                  memberPrice: 20000,
                                  category: 'Nasi',
                                  description:
                                      'Mie ayam bakso dengan kuah gurih, daging ayam suwir, bakso kenyal, dan irisan daun bawang. Menu mie yang lezat dan menggugah selera.',
                                  image: 'mie_ayam_bakso.png',
                                  count: 1,
                                  tag: 'Chicken',
                                ),
                              ],
                            );
                          }));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

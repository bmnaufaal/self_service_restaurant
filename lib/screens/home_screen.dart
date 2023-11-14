import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/widgets/buttons/category_button.dart';
import 'package:lunapos_akpsi/widgets/buttons/checkout_button.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/custom_search_bar.dart';
import 'package:lunapos_akpsi/widgets/list_items/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoggedIn = false;
  bool isSemuaActive = true;
  bool isNasiActive = false;
  bool isMieActive = false;
  bool isSayuranActive = false;
  bool isMakananRinganActive = false;
  bool isMakananPenutupActive = false;
  bool isMinumanActive = false;
  int itemCount = 0;
  int totalPrice = 0;
  List<String> items = ['Box 1', 'Box 2', 'Box 3', 'Box 4', 'Box 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'LOGO',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: PrimaryButton(
              title: 'Masuk',
              icon: Icons.person_outline,
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                const CustomSearchBar(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Kategori',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryButton(
                        title: 'Semua',
                        isActive: isSemuaActive,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Nasi',
                        isActive: isNasiActive,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Mie',
                        isActive: isMieActive,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Sayuran',
                        isActive: isSayuranActive,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Makanan Ringan',
                        isActive: isMakananRinganActive,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Makanan Penutup',
                        isActive: isMakananPenutupActive,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Minuman',
                        isActive: isMinumanActive,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: GridView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => const ItemCard(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      mainAxisExtent: 300,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 15),
              child: CheckoutButton(
                itemCount: itemCount,
                totalPrice: totalPrice,
                icon: Icons.shopping_basket,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

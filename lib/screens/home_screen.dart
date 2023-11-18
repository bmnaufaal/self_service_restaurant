import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_bloc.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_event.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_state.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';
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
  List<MenuItem> data = [];
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void activateCategory(String category) {
    isSemuaActive = false;
    isNasiActive = false;
    isMieActive = false;
    isSayuranActive = false;
    isMakananRinganActive = false;
    isMakananPenutupActive = false;
    isMinumanActive = false;

    switch (category) {
      case 'Semua':
        isSemuaActive = true;
        break;
      case 'Nasi':
        isNasiActive = true;
        break;
      case 'Mie':
        isMieActive = true;
        break;
      case 'Sayuran':
        isSayuranActive = true;
        break;
      case 'Makanan Ringan':
        isMakananRinganActive = true;
        break;
      case 'Makanan Penutup':
        isMakananPenutupActive = true;
        break;
      case 'Minuman':
        isMinumanActive = true;
        break;
      default:
        break;
    }
  }

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
                CustomSearchBar(
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      BlocProvider.of<MenuBloc>(context).add(SearchItem(value));
                    });
                  },
                ),
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
                        onPressed: () {
                          setState(() {
                            isSemuaActive = true;
                            activateCategory('Semua');
                          });
                          BlocProvider.of<MenuBloc>(context).add(GetMenuItem());
                        },
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Nasi',
                        isActive: isNasiActive,
                        onPressed: () {
                          setState(() {
                            isNasiActive = true;
                            activateCategory('Nasi');
                          });
                          BlocProvider.of<MenuBloc>(context)
                              .add(const SelectCategoryItem('Nasi'));
                        },
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Mie',
                        isActive: isMieActive,
                        onPressed: () {
                          setState(() {
                            isMieActive = true;
                            activateCategory('Mie');
                          });
                          BlocProvider.of<MenuBloc>(context)
                              .add(const SelectCategoryItem('Mie'));
                        },
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Sayuran',
                        isActive: isSayuranActive,
                        onPressed: () {
                          setState(() {
                            isSayuranActive = true;
                            activateCategory('Sayuran');
                          });
                          BlocProvider.of<MenuBloc>(context)
                              .add(const SelectCategoryItem('Sayuran'));
                        },
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Makanan Ringan',
                        isActive: isMakananRinganActive,
                        onPressed: () {
                          setState(() {
                            isMakananRinganActive = true;
                            activateCategory('Makanan Ringan');
                          });
                          BlocProvider.of<MenuBloc>(context)
                              .add(const SelectCategoryItem('Makanan Ringan'));
                        },
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Makanan Penutup',
                        isActive: isMakananPenutupActive,
                        onPressed: () {
                          setState(() {
                            isMakananPenutupActive = true;
                            activateCategory('Makanan Penutup');
                          });
                          BlocProvider.of<MenuBloc>(context)
                              .add(const SelectCategoryItem('Makanan Penutup'));
                        },
                      ),
                      const SizedBox(width: 15),
                      CategoryButton(
                        title: 'Minuman',
                        isActive: isMinumanActive,
                        onPressed: () {
                          setState(() {
                            isMinumanActive = true;
                            activateCategory('Minuman');
                          });
                          BlocProvider.of<MenuBloc>(context)
                              .add(const SelectCategoryItem('Minuman'));
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                BlocBuilder<MenuBloc, MenuState>(
                  builder: (context, state) {
                    if (state is MenuLoadingState) {
                      return Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      );
                    }

                    if (state is MenuLoadedState) {
                      data = state.data;
                    }

                    return Expanded(
                      child: GridView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ItemCard(
                            title: data[index].name,
                            price: data[index].price,
                            image: data[index].image,
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          mainAxisExtent: 300,
                        ),
                      ),
                    );
                  },
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

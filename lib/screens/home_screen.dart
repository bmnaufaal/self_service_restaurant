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
import 'package:lunapos_akpsi/widgets/modals/login_modal.dart';

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
  int totalCount = 0;
  int totalPrice = 0;
  int loyaltyPoint = 0;
  List<MenuItem> data = [];
  List<MenuItem> cart = [];
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  int calculateTotalCount(List<MenuItem> items) {
    return items.fold(0, (sum, item) => sum + item.count);
  }

  int calculateTotalPrice(List<MenuItem> items) {
    return items
        .where((item) => item.count > 0)
        .fold(0, (sum, item) => sum + (item.price * item.count));
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
          if (isLoggedIn == false)
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: PrimaryButton(
                title: 'Masuk',
                icon: Icons.person_outline,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return LoginModal(
                        onPressed: () {
                          setState(() {
                            isLoggedIn = !isLoggedIn;
                          });
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          if (isLoggedIn == true)
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  const Icon(
                    Icons.stars_outlined,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    loyaltyPoint.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          if (isLoggedIn == true)
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: PrimaryButton(
                title: 'User',
                icon: Icons.person_outline,
                onPressed: () {
                  setState(() {
                    isLoggedIn = !isLoggedIn;
                  });
                },
              ),
            ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<MenuBloc>(
            create: (context) {
              final MenuBloc bloc = MenuBloc();
              bloc.add(GetMenuItem(cart));
              return bloc;
            },
          ),
        ],
        child: BlocBuilder<MenuBloc, MenuState>(
          builder: (context, state) {
            if (state is MenuLoadedState) {
              data = state.data;
              cart = state.cart;
              totalCount = calculateTotalCount(cart);
              totalPrice = calculateTotalPrice(cart);
            }

            return Container(
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    children: [
                      CustomSearchBar(
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce?.cancel();
                          _debounce =
                              Timer(const Duration(milliseconds: 500), () {
                            BlocProvider.of<MenuBloc>(context)
                                .add(SearchItem(cart, value));
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
                                BlocProvider.of<MenuBloc>(context)
                                    .add(GetMenuItem(cart));
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
                                    .add(SelectCategoryItem(
                                  cart,
                                  'Nasi',
                                ));
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
                                    .add(SelectCategoryItem(
                                  cart,
                                  'Mie',
                                ));
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
                                    .add(SelectCategoryItem(
                                  cart,
                                  'Sayuran',
                                ));
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
                                    .add(SelectCategoryItem(
                                  cart,
                                  'Makanan Ringan',
                                ));
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
                                    .add(SelectCategoryItem(
                                  cart,
                                  'Makanan Penutup',
                                ));
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
                                    .add(SelectCategoryItem(
                                  cart,
                                  'Minuman',
                                ));
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: GridView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            MenuItem currentItem = data[index];
                            int itemCountInCart = cart
                                .where((cartItem) =>
                                    cartItem.name == currentItem.name)
                                .fold(
                                    0, (sum, cartItem) => sum + cartItem.count);

                            return ItemCard(
                              title: currentItem.name,
                              price: currentItem.price,
                              image: currentItem.image,
                              description: currentItem.description,
                              count: itemCountInCart,
                              order: (item) {
                                BlocProvider.of<MenuBloc>(context).add(
                                  AddCountItem(data, currentItem.name),
                                );
                              },
                              onAdd: (item) {
                                BlocProvider.of<MenuBloc>(context).add(
                                  AddCountItem(data, currentItem.name),
                                );
                              },
                              onRemove: (item) {
                                BlocProvider.of<MenuBloc>(context).add(
                                  RemoveCountItem(data, currentItem.name),
                                );
                              },
                              list: data,
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
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CheckoutButton(
                      itemCount: totalCount,
                      totalPrice: totalPrice,
                      icon: Icons.shopping_basket,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

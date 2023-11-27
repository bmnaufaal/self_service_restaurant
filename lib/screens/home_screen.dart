import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/login/login_bloc.dart';
import 'package:lunapos_akpsi/bloc/login/login_state.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_bloc.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_event.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_state.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';
import 'package:lunapos_akpsi/screens/account_order_screen.dart';
import 'package:lunapos_akpsi/screens/cart_screen.dart';
import 'package:lunapos_akpsi/widgets/alerts/error_alert.dart';
import 'package:lunapos_akpsi/widgets/buttons/category_button.dart';
import 'package:lunapos_akpsi/widgets/buttons/checkout_button.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/buttons/user_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/custom_search_bar.dart';
import 'package:lunapos_akpsi/widgets/list_items/item_card.dart';
import 'package:lunapos_akpsi/widgets/modals/invite_modal.dart';
import 'package:lunapos_akpsi/widgets/modals/login_modal.dart';
import 'package:lunapos_akpsi/widgets/modals/promo_modal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
    this.cart,
    this.date,
    this.time,
    this.guest,
    this.isLoggedIn,
    this.userName,
    this.loyaltyPoints,
    this.onChangeLanguage,
  });

  List<MenuItem>? cart;
  String? date;
  String? time;
  String? guest;
  bool? isLoggedIn;
  String? userName;
  int? loyaltyPoints;
  dynamic? onChangeLanguage;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInviter = false;
  bool isInvitee = false;
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
  List<MenuItem> data = [];
  List<MenuItem> cart = [];
  Timer? _debounce;
  String userName = '';
  int loyaltyPoints = 0;
  List<String> languages = ['en', 'id'];

  @override
  void initState() {
    super.initState();
    if (widget.cart != null) {
      cart = widget.cart!;
      isLoggedIn = widget.isLoggedIn!;
      userName = widget.userName!;
      loyaltyPoints = widget.loyaltyPoints!;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
        context: context,
        builder: (context) {
          return const PromoModal();
        },
      );
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  int calculateTotalCount(List<MenuItem> items) {
    return items.fold(0, (sum, item) => sum + item.count);
  }

  int calculateTotalPrice(List<MenuItem> items, bool isLoggedIn) {
    int total = 0;
    if (isLoggedIn == true) {
      total = items
          .where((item) => item.count > 0)
          .fold(0, (sum, item) => sum + (item.memberPrice! * item.count));
    } else {
      total = items
          .where((item) => item.count > 0)
          .fold(0, (sum, item) => sum + (item.price * item.count));
    }

    return total;
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final MenuBloc bloc = MenuBloc();
            bloc.add(GetMenuItem(cart));
            return bloc;
          },
        ),
      ],
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadedState) {
            Navigator.of(context).pop();
            isLoggedIn = true;
            userName = state.userName;
            loyaltyPoints = state.points;
          }

          if (state is LoginErrorState) {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) {
                return ErrorAlert(message: state.error);
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 90,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                mainAxisAlignment: (widget.guest == null)
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: (widget.guest == null)
                    ? [
                        const Text(
                          'LOGO',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownMenu<String>(
                          inputDecorationTheme: const InputDecorationTheme(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                            ),
                          ),
                          width: 80,
                          initialSelection: languages.first,
                          onSelected: (String? value) {
                            widget.onChangeLanguage(value);
                          },
                          dropdownMenuEntries:
                              languages.map<DropdownMenuEntry<String>>(
                            (String value) {
                              return DropdownMenuEntry<String>(
                                value: value,
                                label: value.toUpperCase(),
                              );
                            },
                          ).toList(),
                        ),
                      ]
                    : [
                        Text(
                          '${AppLocalizations.of(context)!.scheduledOrder} - ${widget.date}:${widget.time} - ${widget.guest} ${AppLocalizations.of(context)!.guest}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
              ),
              centerTitle: false,
              actions: (widget.guest == null)
                  ? [
                      if (isLoggedIn == false)
                        Container(
                          padding: const EdgeInsets.only(right: 15),
                          child: PrimaryButton(
                            title: AppLocalizations.of(context)!.login,
                            icon: Icons.person_outline,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const LoginModal();
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
                                loyaltyPoints.toString(),
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
                            title: userName,
                            icon: Icons.person_outline,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) {
                                  return AccountOrderScreen(
                                    userName: userName,
                                    loyaltyPoints: loyaltyPoints,
                                    onChangeLanguage: widget.onChangeLanguage,
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                    ]
                  : [],
            ),
            body: BlocBuilder<MenuBloc, MenuState>(
              builder: (context, state) {
                if (state is MenuLoadedState) {
                  data = state.data;
                  cart = state.cart;
                  totalCount = calculateTotalCount(cart);
                  totalPrice = calculateTotalPrice(cart, isLoggedIn);
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
                              if (_debounce?.isActive ?? false) {
                                _debounce?.cancel();
                              }
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
                              AppLocalizations.of(context)!.category,
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
                                  title: AppLocalizations.of(context)!.all,
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
                                  title: AppLocalizations.of(context)!.rice,
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
                                  title: AppLocalizations.of(context)!.noodles,
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
                                  title:
                                      AppLocalizations.of(context)!.vegetables,
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
                                  title: AppLocalizations.of(context)!.snacks,
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
                                  title: AppLocalizations.of(context)!.dessert,
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
                                  title:
                                      AppLocalizations.of(context)!.beverages,
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
                                        0,
                                        (sum, cartItem) =>
                                            sum + cartItem.count);

                                return ItemCard(
                                  title: currentItem.name,
                                  price: currentItem.price,
                                  memberPrice: currentItem.memberPrice,
                                  image: currentItem.image,
                                  description: currentItem.description,
                                  count: itemCountInCart,
                                  isLoggedIn: isLoggedIn,
                                  order: (item) {
                                    BlocProvider.of<MenuBloc>(context).add(
                                      AddCountItem(
                                          data, currentItem.name, cart),
                                    );
                                  },
                                  onAdd: (item) {
                                    BlocProvider.of<MenuBloc>(context).add(
                                      AddCountItem(
                                          data, currentItem.name, cart),
                                    );
                                  },
                                  onRemove: (item) {
                                    BlocProvider.of<MenuBloc>(context).add(
                                      RemoveCountItem(
                                          data, currentItem.name, cart),
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
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Visibility(
                                visible: (cart.isNotEmpty) ? true : false,
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  child: CheckoutButton(
                                    itemCount: totalCount,
                                    totalPrice: totalPrice,
                                    icon: Icons.shopping_basket,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) {
                                          return CartScreen(
                                            userName: userName,
                                            cart: cart,
                                            bloc: BlocProvider.of<MenuBloc>(
                                                context),
                                            isLoggedIn: isLoggedIn,
                                            points: loyaltyPoints,
                                            isJoinOrder: (isInvitee == true ||
                                                isInviter == true),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  height: 47,
                                  child: UserButton(
                                    title: (isInvitee == true)
                                        ? '${AppLocalizations.of(context)!.table} 1'
                                        : '',
                                    icon: Icons.person,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return InviteModal(
                                            onImageClicked: () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isInvitee = true;
                                                isInviter = false;
                                              });
                                            },
                                            onClose: () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isInvitee = false;
                                                isInviter = true;
                                              });
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

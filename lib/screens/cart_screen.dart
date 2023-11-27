import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/bloc/cart/cart_bloc.dart';
import 'package:lunapos_akpsi/bloc/cart/cart_event.dart';
import 'package:lunapos_akpsi/bloc/cart/cart_state.dart';
import 'package:lunapos_akpsi/bloc/coupon/coupon_bloc.dart';
import 'package:lunapos_akpsi/bloc/coupon/coupon_state.dart';
import 'package:lunapos_akpsi/bloc/loyalty_point/loyalty_point_bloc.dart';
import 'package:lunapos_akpsi/bloc/loyalty_point/loyalty_point_event.dart';
import 'package:lunapos_akpsi/bloc/loyalty_point/loyalty_point_state.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_bloc.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_event.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';
import 'package:lunapos_akpsi/widgets/alerts/error_alert.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/modals/coupon_modal.dart';
import 'package:lunapos_akpsi/widgets/modals/loyalty_point_modal.dart';
import 'package:lunapos_akpsi/widgets/modals/payment_modal.dart';

class CartScreen extends StatefulWidget {
  CartScreen({
    super.key,
    required this.cart,
    required this.bloc,
    required this.isLoggedIn,
    required this.userName,
    required this.points,
    required this.isJoinOrder,
  });

  final List<MenuItem> cart;
  final MenuBloc bloc;
  final bool isLoggedIn;
  final String userName;
  int points;
  final bool isJoinOrder;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<MenuItem> cart = [];
  String validCoupon = 'COUPON1';
  bool isCouponValid = false;
  double loyaltyDiscount = 0;
  int loyaltyDiscountPercent = 0;
  int totalCount = 0;

  int calculateTotalPrice(List<MenuItem> items, bool isLoggedIn) {
    double total = 0;
    if (isLoggedIn == true) {
      total = items.where((item) => item.count > 0).fold(
          0,
          (sum, item) =>
              sum + ((item.memberPrice! * (1 - loyaltyDiscount)) * item.count));
    } else {
      total = items.where((item) => item.count > 0).fold(
          0,
          (sum, item) =>
              sum + ((item.price * (1 - loyaltyDiscount)) * item.count));
    }

    return (widget.isJoinOrder == true) ? total.toInt() + 20000 : total.toInt();
  }

  int calculateTotalPriceWithDiscount(List<MenuItem> items, bool isLoggedIn) {
    double total = 0;
    if (isLoggedIn == true) {
      total = items.where((item) => item.count > 0).fold(
          0,
          (sum, item) =>
              sum +
              ((item.memberPrice! * 0.9 * (1 - loyaltyDiscount)) * item.count));
    } else {
      total = items.where((item) => item.count > 0).fold(
          0,
          (sum, item) =>
              sum + ((item.price * 0.9 * (1 - loyaltyDiscount)) * item.count));
    }

    return (widget.isJoinOrder == true) ? total.toInt() + 20000 : total.toInt();
  }

  bool checkDiscount(int price, int memberPrice) {
    if (widget.isLoggedIn == true) {
      if (price != memberPrice) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  int calculateDiscountAmount(List<MenuItem> items, bool isLoggedIn) {
    int totalAmount = calculateTotalPrice(cart, isLoggedIn);
    int discountedAmount = calculateTotalPriceWithDiscount(cart, isLoggedIn);
    return totalAmount - discountedAmount;
  }

  int calculateTotalCount(List<MenuItem> items) {
    return items.fold(0, (sum, item) => sum + item.count);
  }

  int calculateLoyaltyDiscountAmount(
    List<MenuItem> items,
    bool isLoggedIn,
    double loyaltyDiscount,
  ) {
    int totalAmount = 0;
    if (isLoggedIn == true) {
      totalAmount = items
          .where((item) => item.count > 0)
          .fold(0, (sum, item) => sum + ((item.memberPrice!) * item.count));
    } else {
      totalAmount = items
          .where((item) => item.count > 0)
          .fold(0, (sum, item) => sum + ((item.price) * item.count));
    }

    int discountedTotal = calculateTotalPrice(items, isLoggedIn);
    return (totalAmount - discountedTotal).toInt();
  }

  @override
  void initState() {
    super.initState();
    cart = widget.cart;
    totalCount = calculateTotalCount(cart);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoyaltyPointBloc, LoyaltyPointState>(
      listener: (context, state) {
        if (state is LoyaltyPointLoadedState) {
          loyaltyDiscount = state.discount / 100;
          loyaltyDiscountPercent = state.discount;
        }

        if (state is LoyaltyPointErrorState) {
          showDialog(
            context: context,
            builder: (context) {
              return ErrorAlert(message: state.error);
            },
          );
        }
      },
      builder: (context, state) {
        return BlocConsumer<CouponBloc, CouponState>(
          listener: (context, state) {
            if (state is CouponLoadedState) {
              Navigator.of(context).pop();
              isCouponValid = true;
            }

            if (state is ItemCouponLoadedState) {
              Navigator.of(context).pop();
              cart.add(
                MenuItem(
                  name: 'Jus Mangga Segar',
                  price: 0,
                  memberPrice: 0,
                  category: 'category',
                  description: 'description',
                  image: 'jus_mangga.png',
                  count: -1,
                  tag: 'Beverage',
                ),
              );
            }

            if (state is CouponErrorState) {
              showDialog(
                context: context,
                builder: (context) {
                  return ErrorAlert(message: state.error);
                },
              );
            }
          },
          builder: (context, state) {
            return PopScope(
              onPopInvoked: (bool didPop) {
                cart.removeWhere((item) => item.count == -1);
                widget.bloc.add(GetMenuItem(cart));
              },
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: const Text(
                    'Cart',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  centerTitle: false,
                ),
                body: MultiBlocProvider(
                  providers: [
                    BlocProvider<CartBloc>(
                      create: (context) {
                        final CartBloc bloc = CartBloc();
                        return bloc;
                      },
                    ),
                  ],
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartLoadedState) {
                        cart = state.cart;
                        totalCount = calculateTotalCount(cart);
                      }

                      return Container(
                        padding: const EdgeInsets.all(5),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.isJoinOrder == true)
                              PrimaryButton(
                                title: 'John Doe',
                                onPressed: () {},
                              ),
                            if (widget.isJoinOrder == true)
                              Card(
                                color: const Color(0xFF53387D),
                                child: Row(
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
                                              'assets/images/mie_ayam_bakso.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Mie Ayam Bakso',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                      locale: 'id_ID',
                                                      symbol: 'Rp')
                                                  .format(
                                                20000,
                                              ),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (widget.isJoinOrder == true)
                              PrimaryButton(
                                title: (widget.userName != '')
                                    ? widget.userName
                                    : 'Guest',
                                onPressed: () {},
                              ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: cart.length,
                                itemBuilder: (context, index) {
                                  int price = cart[index].price;
                                  int? memberPrice = cart[index].memberPrice;

                                  return Card(
                                    color: const Color(0xFF53387D),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 125,
                                          height: 125,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/${cart[index].image}'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cart[index].name,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  NumberFormat.currency(
                                                          locale: 'id_ID',
                                                          symbol: 'Rp')
                                                      .format(
                                                    cart[index].price,
                                                  ),
                                                  style: TextStyle(
                                                    color: (checkDiscount(price,
                                                                memberPrice!) ==
                                                            true)
                                                        ? Colors.red
                                                        : Colors.white,
                                                    decoration: checkDiscount(
                                                                price,
                                                                memberPrice) ==
                                                            true
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                                if (checkDiscount(
                                                        cart[index].price,
                                                        cart[index]
                                                            .memberPrice!) ==
                                                    true)
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'id_ID',
                                                            symbol: 'Rp')
                                                        .format(
                                                      cart[index].memberPrice,
                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (cart[index].count != -1)
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 13),
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    child: IconButton(
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    CartBloc>(
                                                                context)
                                                            .add(DeleteItemCart(
                                                          cart,
                                                          cart[index].name,
                                                        ));
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    CartBloc>(
                                                                context)
                                                            .add(
                                                                RemoveCountCart(
                                                          cart,
                                                          cart[index].name,
                                                        ));
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      cart[index]
                                                          .count
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    CartBloc>(
                                                                context)
                                                            .add(AddCountCart(
                                                          cart,
                                                          cart[index].name,
                                                        ));
                                                      },
                                                      icon: const Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                children: [
                                  if (loyaltyDiscount == 0 && widget.isLoggedIn)
                                    Container(
                                      padding: const EdgeInsets.only(left: 15),
                                      alignment: Alignment.centerLeft,
                                      child: PrimaryButton(
                                        title: 'Use Loyalty Point',
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return LoyaltyPointModal(
                                                loyaltyPoints: widget.points,
                                                onSelected:
                                                    (int value, int percent) {
                                                  BlocProvider.of<
                                                              LoyaltyPointBloc>(
                                                          context)
                                                      .add(
                                                    PostLoyaltyPoint(
                                                      percent,
                                                      value,
                                                      widget.points,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  if (loyaltyDiscount > 0)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Loyalty Point (Disc $loyaltyDiscountPercent %)',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.green,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '- ${NumberFormat.currency(
                                              locale: 'id_ID',
                                              symbol: 'Rp',
                                            ).format(
                                              calculateLoyaltyDiscountAmount(
                                                cart,
                                                widget.isLoggedIn,
                                                loyaltyDiscount,
                                              ),
                                            )}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        if (isCouponValid == false)
                                          PrimaryButton(
                                            icon: Icons.local_activity,
                                            title: 'Use a coupon',
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const CouponModal();
                                                },
                                              );
                                            },
                                          ),
                                        if (isCouponValid == true)
                                          const Text(
                                            'Coupon (Discount 10%)',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green,
                                            ),
                                          ),
                                        if (isCouponValid == true)
                                          const Spacer(),
                                        if (isCouponValid == true)
                                          Text(
                                            '- ${NumberFormat.currency(
                                              locale: 'id_ID',
                                              symbol: 'Rp',
                                            ).format(
                                              calculateDiscountAmount(
                                                  cart, widget.isLoggedIn),
                                            )}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Colors.green,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Total',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                            (isCouponValid != true)
                                                ? Text(
                                                    NumberFormat.currency(
                                                            locale: 'id_ID',
                                                            symbol: 'Rp')
                                                        .format(
                                                      calculateTotalPrice(cart,
                                                          widget.isLoggedIn),
                                                    ),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 20,
                                                    ),
                                                  )
                                                : Text(
                                                    NumberFormat.currency(
                                                            locale: 'id_ID',
                                                            symbol: 'Rp')
                                                        .format(
                                                      calculateTotalPriceWithDiscount(
                                                        cart,
                                                        widget.isLoggedIn,
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        const Spacer(),
                                        PrimaryButton(
                                          maxWidth: true,
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return PaymentModal(
                                                  isLoggedIn: widget.isLoggedIn,
                                                  totalPrice: (isCouponValid !=
                                                          true)
                                                      ? calculateTotalPrice(
                                                          cart,
                                                          widget.isLoggedIn,
                                                        )
                                                      : calculateTotalPriceWithDiscount(
                                                          cart,
                                                          widget.isJoinOrder,
                                                        ),
                                                );
                                              },
                                            );
                                          },
                                          title: 'Checkout ($totalCount)',
                                        ),
                                      ],
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
                ),
              ),
            );
          },
        );
      },
    );
  }
}

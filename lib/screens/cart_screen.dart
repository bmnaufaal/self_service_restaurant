import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/bloc/cart/cart_bloc.dart';
import 'package:lunapos_akpsi/bloc/cart/cart_event.dart';
import 'package:lunapos_akpsi/bloc/cart/cart_state.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_bloc.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_event.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';
import 'package:lunapos_akpsi/widgets/alerts/error_alert.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/modals/coupon_modal.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    required this.cart,
    required this.bloc,
    required this.isLoggedIn,
  });

  final List<MenuItem> cart;
  final MenuBloc bloc;
  final bool isLoggedIn;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<MenuItem> cart = [];
  String validCoupon = 'COUPON1';
  bool isCouponValid = false;
  int discount = 0;

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

  int calculateTotalPriceWithDiscount(List<MenuItem> items, bool isLoggedIn) {
    double total = 0;
    if (isLoggedIn == true) {
      total = items.where((item) => item.count > 0).fold(
          0, (sum, item) => sum + ((item.memberPrice! * 0.9) * item.count));
    } else {
      total = items
          .where((item) => item.count > 0)
          .fold(0, (sum, item) => sum + (item.price * item.count));
    }

    return total as int;
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

  @override
  void initState() {
    super.initState();
    cart = widget.cart;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool didPop) {
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
              }

              return Container(
                padding: const EdgeInsets.all(5),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images///${cart[index].image}'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
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
                                                  locale: 'id_ID', symbol: 'Rp')
                                              .format(
                                            cart[index].price,
                                          ),
                                          style: TextStyle(
                                            color: (checkDiscount(
                                                        price, memberPrice!) ==
                                                    true)
                                                ? Colors.red
                                                : Colors.white,
                                            decoration: checkDiscount(
                                                        price, memberPrice) ==
                                                    true
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        if (checkDiscount(cart[index].price,
                                                cart[index].memberPrice!) ==
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: IconButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              BlocProvider.of<CartBloc>(context)
                                                  .add(DeleteItemCart(
                                                cart,
                                                cart[index].name,
                                              ));
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              BlocProvider.of<CartBloc>(context)
                                                  .add(RemoveCountCart(
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
                                            cart[index].count.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              BlocProvider.of<CartBloc>(context)
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
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: isCouponValid == true ? true : false,
                                  child: const Text(
                                    'Coupon (Discount 10%)',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            trailing: (isCouponValid != true)
                                ? Text(
                                    NumberFormat.currency(
                                            locale: 'id_ID', symbol: 'Rp')
                                        .format(
                                      calculateTotalPrice(
                                          cart, widget.isLoggedIn),
                                    ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
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
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id_ID', symbol: 'Rp')
                                            .format(
                                          calculateTotalPriceWithDiscount(
                                              cart, widget.isLoggedIn),
                                        ),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          ListTile(
                            leading: PrimaryButton(
                              icon: Icons.local_activity,
                              title: 'Use a coupon',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CouponModal(
                                      onPressed: (String value) {
                                        if (value == validCoupon) {
                                          setState(() {
                                            isCouponValid = true;
                                            discount = 10000;
                                          });
                                        } else {
                                          setState(() {
                                            isCouponValid = false;
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const ErrorAlert(
                                                  message:
                                                      'Coupon is not valid',
                                                );
                                              },
                                            );
                                          });
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            trailing: PrimaryButton(
                              title: 'Checkout',
                              onPressed: () {},
                            ),
                          )
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
  }
}

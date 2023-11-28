import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/models/menu_item.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/modals/payment_modal.dart';

class DetailOrder extends StatefulWidget {
  const DetailOrder({
    super.key,
    required this.cart,
    required this.loyaltyDiscount,
    required this.couponDiscount,
    required this.totalPrice,
    required this.isJoinOrder,
    required this.isLoggedIn,
    required this.userName,
  });

  final List<MenuItem> cart;
  final int loyaltyDiscount;
  final int couponDiscount;
  final int totalPrice;
  final bool isJoinOrder;
  final bool isLoggedIn;
  final String userName;

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  int calculateTotal() {
    return widget.totalPrice - widget.couponDiscount - widget.loyaltyDiscount;
  }

  int calculateSubtotal() {
    double total = 0;
    if (widget.isLoggedIn == true) {
      total = widget.cart
          .where((item) => item.count > 0)
          .fold(0, (sum, item) => sum + ((item.memberPrice!) * item.count));
    } else {
      total = widget.cart
          .where((item) => item.count > 0)
          .fold(0, (sum, item) => sum + ((item.price) * item.count));
    }

    return total.toInt();
  }

  @override
  void initState() {
    super.initState();
    print(widget.cart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.detailOrder,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.isJoinOrder == true)
              PrimaryButton(
                title: 'John Doe',
                onPressed: () {},
              ),
            if (widget.isJoinOrder == true)
              ListTile(
                leading: const Text(
                  'Mie Ayam Bakso',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: Text(
                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(
                    20000,
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            if (widget.isJoinOrder == true)
              ListTile(
                leading: const Text(
                  'Subtotal',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: Text(
                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(
                    20000,
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            if (widget.isJoinOrder == true)
              PrimaryButton(
                title: (widget.userName != '')
                    ? widget.userName
                    : AppLocalizations.of(context)!.guest,
                onPressed: () {},
              ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.cart.length + 1,
              itemBuilder: (context, index) {
                if (index == widget.cart.length) {
                  return ListTile(
                    leading: const Text(
                      'Subtotal',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: Text(
                      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                          .format(
                        calculateSubtotal(),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListTile(
                  leading: Text(
                    widget.cart[index].name,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: Text(
                    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(
                      widget.cart[index].price,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            const Divider(),
            if (widget.loyaltyDiscount != 0)
              ListTile(
                leading: Text(
                  'Loyalty ${AppLocalizations.of(context)!.discount}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                trailing: Text(
                  '-${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(
                    widget.loyaltyDiscount,
                  )}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ),
            if (widget.couponDiscount != 0)
              ListTile(
                leading: Text(
                  '${AppLocalizations.of(context)!.coupon} ${AppLocalizations.of(context)!.discount}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                trailing: Text(
                  '-${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(
                    widget.couponDiscount,
                  )}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ),
            ListTile(
              leading: const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(
                  calculateTotal(),
                ),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                title: AppLocalizations.of(context)!.checkout,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PaymentModal(
                        isLoggedIn: widget.isLoggedIn,
                        totalPrice: calculateTotal(),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

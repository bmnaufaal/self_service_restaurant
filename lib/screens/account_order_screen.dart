import 'package:flutter/material.dart';
import 'package:lunapos_akpsi/screens/history_order_screen.dart';
import 'package:lunapos_akpsi/screens/home_screen.dart';
import 'package:lunapos_akpsi/screens/scheduled_order_screen.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/modals/account_modal.dart';
import 'package:lunapos_akpsi/widgets/modals/login_modal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountOrderScreen extends StatefulWidget {
  AccountOrderScreen({
    super.key,
    this.userName,
    this.loyaltyPoints,
    this.onChangeLanguage,
  });

  String? userName;
  int? loyaltyPoints;
  dynamic? onChangeLanguage;

  @override
  State<AccountOrderScreen> createState() => _AccountOrderScreenState();
}

class _AccountOrderScreenState extends State<AccountOrderScreen> {
  List<String> languages = ['en', 'id'];
  bool isLoggedIn = false;
  int loyaltyPoints = 0;
  String userName = '';

  @override
  void initState() {
    super.initState();
    if (widget.userName != '') {
      isLoggedIn = true;
      userName = widget.userName!;
      loyaltyPoints = widget.loyaltyPoints!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
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
              dropdownMenuEntries: languages.map<DropdownMenuEntry<String>>(
                (String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value.toUpperCase(),
                  );
                },
              ).toList(),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
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
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AccountModal(
                        name: userName,
                        onPressed: () {
                          Navigator.of(context).popUntil(
                            (route) => route.isFirst,
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => HomeScreen(
                                onChangeLanguage: widget.onChangeLanguage,
                              ),
                            ),
                          );
                          setState(() {
                            isLoggedIn = !isLoggedIn;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: AppLocalizations.of(context)!.historyOrder,
                  ),
                  Tab(
                    text: AppLocalizations.of(context)!.scheduledOrder,
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    const HistoryOrderScreen(),
                    ScheduledOrderScreen(
                      onChangeLanguage: widget.onChangeLanguage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

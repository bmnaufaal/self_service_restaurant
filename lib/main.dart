import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/coupon/coupon_bloc.dart';
import 'package:lunapos_akpsi/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:lunapos_akpsi/bloc/login/login_bloc.dart';
import 'package:lunapos_akpsi/bloc/loyalty_point/loyalty_point_bloc.dart';
import 'package:lunapos_akpsi/bloc/otp/otp_bloc.dart';
import 'package:lunapos_akpsi/bloc/register/register_bloc.dart';
import 'package:lunapos_akpsi/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  final runnableApp = _builApp(
    isWeb: kIsWeb,
    webAppWidth: 425.0,
    app: MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) {
            final LoginBloc bloc = LoginBloc();
            return bloc;
          },
        ),
        BlocProvider<RegisterBloc>(
          create: (context) {
            final RegisterBloc bloc = RegisterBloc();
            return bloc;
          },
        ),
        BlocProvider<OTPBloc>(
          create: (context) {
            final OTPBloc bloc = OTPBloc();
            return bloc;
          },
        ),
        BlocProvider<ForgotPasswordBloc>(
          create: (context) {
            final ForgotPasswordBloc bloc = ForgotPasswordBloc();
            return bloc;
          },
        ),
        BlocProvider<CouponBloc>(
          create: (context) {
            final CouponBloc bloc = CouponBloc();
            return bloc;
          },
        ),
        BlocProvider<LoyaltyPointBloc>(
          create: (context) {
            final LoyaltyPointBloc bloc = LoyaltyPointBloc();
            return bloc;
          },
        ),
      ],
      child: const SelfServiceApp(),
    ),
  );

  runApp(runnableApp);
}

class SelfServiceApp extends StatefulWidget {
  const SelfServiceApp({super.key});

  @override
  State<SelfServiceApp> createState() => _SelfServiceAppState();
}

Widget _builApp({
  required bool isWeb,
  required double webAppWidth,
  required Widget app,
}) {
  if (!isWeb) {
    return app;
  }

  return Center(
    child: ClipRect(
      child: SizedBox(
        width: webAppWidth,
        child: app,
      ),
    ),
  );
}

class _SelfServiceAppState extends State<SelfServiceApp> {
  String language = 'en';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(language),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        dialogBackgroundColor: Colors.white,
        textTheme: GoogleFonts.openSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF53387D),
          surface: Colors.white,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        onChangeLanguage: (value) {
          setState(() {
            language = value;
          });
        },
      ),
    );
  }
}

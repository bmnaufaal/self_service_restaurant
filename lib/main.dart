import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_bloc.dart';
import 'package:lunapos_akpsi/bloc/menu/menu_event.dart';
import 'package:lunapos_akpsi/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MenuBloc>(
          create: (context) {
            final MenuBloc bloc = MenuBloc();
            bloc.add(GetMenuItem());
            return bloc;
          },
        ),
      ],
      child: const Lunapos(),
    ),
  );
}

class Lunapos extends StatefulWidget {
  const Lunapos({super.key});

  @override
  State<Lunapos> createState() => _LunaposState();
}

class _LunaposState extends State<Lunapos> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          dialogBackgroundColor: Colors.white,
          textTheme: GoogleFonts.openSansTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF53387D),
            surface: Colors.white,
          ),
          useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

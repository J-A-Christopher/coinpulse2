import 'package:coinpulse2/2_Presentation/core/services/blocobserver.dart';
import 'package:coinpulse2/2_Presentation/core/utils/bottomnavbar_service.dart';
import 'package:coinpulse2/2_Presentation/core/utils/colors.dart';
import 'package:coinpulse2/2_Presentation/pages/dialogpage/dialog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppGlobalBlocObserver();
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coin Pulse',
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
              primary: ColorsUsed.primaryColor,
              secondary: ColorsUsed.secondaryColor)),
      home: const BottomNavBar(),
    );
  }
}

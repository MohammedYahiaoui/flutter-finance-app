import 'package:finance/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:finance/models/finance_model.dart';
import 'package:finance/pages/home.dart';
import 'package:finance/pages/on_boarding.dart';
import 'package:finance/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FinanceModelAdapter());
  await Hive.openBox<FinanceModel>("financeBox");
  await Hive.openBox("darkModeBox");
  runApp(FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchDataCubit(),
      child: ValueListenableBuilder(
        valueListenable: Hive.box("darkModeBox").listenable(),
        builder: (context, box, child) {
          var darkMode = box.get('darkMode', defaultValue: false);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: darkMode? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(useMaterial3: true),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/Helpers/Providers/LanguagesProvider.dart';
import 'package:quran_app/Helpers/Providers/VersesProvider.dart';
import 'package:quran_app/Views/QuranHomeScreen.dart';
import 'package:quran_app/Helpers/Providers/ChaptersProvider.dart';

import 'Helpers/QuranHomeScreenController.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VersesProvider()),
        ChangeNotifierProvider(create: (_) => LanguagesProvider()),
        ChangeNotifierProvider(create: (_) => ChaptersProvider()),
                ChangeNotifierProvider(create: (_) => QuranHomeScreenController()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),),
      home: const QuranHomeScreen(),
    );
  }
}
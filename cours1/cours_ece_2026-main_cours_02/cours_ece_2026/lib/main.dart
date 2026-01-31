import 'package:flutter/material.dart';
import 'package:formation_flutter/l10n/app_localizations.dart';
import 'package:formation_flutter/res/app_colors.dart';
import 'package:formation_flutter/screens/product_page.dart';
import 'package:formation_flutter/model/product.dart';
import 'package:formation_flutter/widget/product_provider.dart';
 
              

void main() {
  runApp(
    ProductProvider(
      product: generateProduct(), 
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: AppColors.nutriscoreA),
        fontFamily: 'Avenir',
        textTheme: TextTheme(headlineMedium: TextStyle()),
      ),
      debugShowCheckedModeBanner: false,
      home: const ProductPage(),
    );
  }
}

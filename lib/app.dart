import 'package:flutter/material.dart';
import 'common/color_extension.dart';
import 'package:hamro_grocery_mobile/splash/splash_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hamro grocery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Gilroy",
        colorScheme: ColorScheme.fromSeed(seedColor: TColor.primary),
        useMaterial3: false,
      ),
      home: SplashScreen(),
      
        
      
    );
  }
}
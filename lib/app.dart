import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamro_grocery_mobile/app/service_locator/service_locator.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view/signin_page.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:hamro_grocery_mobile/splash/splash_screen.dart';

// import 'package:hamro_grocery_mobile/view/auth/dashboard/grocery_app_home.dart';
// import 'package:hamro_grocery_mobile/view/auth/dashboard_view.dart';
import 'common/color_extension.dart';
// import 'package:hamro_grocery_mobile/splash/splash_screen.dart';


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
       home: BlocProvider.value(
        value: serviceLocator<LoginViewModel>(),
        child: SplashScreen(),
      ),
    );
  }
}
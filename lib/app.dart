import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamro_grocery_mobile/app/service_locator/service_locator.dart';
import 'package:hamro_grocery_mobile/app/theme/theme.dart';

import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:hamro_grocery_mobile/splash/splash_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hamro grocery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, 
      home: BlocProvider.value(
        value: serviceLocator<LoginViewModel>(),
        child: SplashScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamro_grocery_mobile/app/service_locator/service_locator.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/profile_view_model/profile_view_model.dart';
import 'package:hamro_grocery_mobile/view/auth/dashboard/history_screen.dart';
import 'package:hamro_grocery_mobile/view/auth/dashboard/home_screen.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view/profile_screen.dart';
import 'package:hamro_grocery_mobile/view/auth/dashboard/order_screen.dart';
import 'package:hamro_grocery_mobile/view/auth/dashboard/shop_list_screen.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const ShopListScreen(),
    const HistoryScreen(),
    const OrderScreen(),
    BlocProvider<ProfileViewModel>.value(
      value: serviceLocator<ProfileViewModel>(),
      child: const ProfileScreen(),
    ),
  ];

  final List<String> _appBarTitles = [
    'Hamro Grocery',
    'Shops',
    'My List',
    'My History',
    'Profile',
  ];

  BottomNavigationCubit()
    : super(
        BottomNavigationState(
          currentIndex: 0,
          currentScreen: const HomeScreen(),
          appBarTitle: 'Hamro Grocery',
        ),
      );

  void updateIndex(int index) {
    if (index >= 0 && index < _screens.length) {
      emit(
        BottomNavigationState(
          currentIndex: index,
          currentScreen: _screens[index],
          appBarTitle: _appBarTitles[index],
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'home.dart';
import 'menu.dart';
import 'order.dart';
import 'locations.dart';

void main() {
  runApp(const CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFcf6317),
          secondary: Color(0xFFC69F74),
          surface: Color(0xFFF8F7F6),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFF4A2C2A),
          onSurface: Color(0xFF000000),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F7F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F7F6),
          foregroundColor: Color(0xFF000000),
          elevation: 0,
        ),
        fontFamily: 'Plus Jakarta Sans',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFcf6317),
          secondary: Color(0xFFC69F74),
          surface: Color(0xFF2E2317),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFFF5F0E6),
          onSurface: Color(0xFFF5F0E6),
        ),
        scaffoldBackgroundColor: const Color(0xFF211811),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF211811),
          foregroundColor: Color(0xFFFFFFFF),
          elevation: 0,
        ),
        fontFamily: 'Plus Jakarta Sans',
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const CoffeeShopHome(),
        '/menu': (context) => const CoffeeShopMenu(),
        '/order': (context) => const OrderPage(),
        '/locations': (context) => const LocationsPage(),
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes like detail page
        if (settings.name?.startsWith('/detail/') == true) {
          // This would require passing the item data differently
          return null;
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

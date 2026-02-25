import 'package:flutter/material.dart';
import '../../features/main_navigation/pages/main_navigation_page.dart';

class AppRoutes {
  AppRoutes._();

  static const home = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const MainNavigationPage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const UnknownRoutePage(),
          settings: settings,
        );
    }
  }
}

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Rota não encontrada'),
      ),
    );
  }
}
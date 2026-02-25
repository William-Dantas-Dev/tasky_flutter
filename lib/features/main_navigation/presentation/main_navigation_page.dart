import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';

class MainNavigationPage extends ConsumerWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          TestPage(title: 'Home'),
          TestPage(title: 'Calendário'),
          TestPage(title: 'Foco'),
          TestPage(title: 'Perfil'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: const Color(0xFF5B6CFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: NavigationBar(
        height: 70,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0x145B6CFF),
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          ref.read(bottomNavIndexProvider.notifier).setIndex(index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Calendário',
          ),
          NavigationDestination(
            icon: Icon(Icons.self_improvement),
            label: 'Foco',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_rounded),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  final String title;

  const TestPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomShell extends StatelessWidget {
  final Widget child;
  const BottomShell({required this.child, super.key});

  static const tabs = ['/dashboard', '/favourites', '/profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index(context),
        onDestinationSelected: (i) => context.go(tabs[i]),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Fav'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  int index(BuildContext context) {
    // final location = GoRouterState.of(context).uri.toString();
    final location = GoRouterState.of(context).matchedLocation;
    return tabs.indexWhere((tab) => location.startsWith(tab));
  }
}

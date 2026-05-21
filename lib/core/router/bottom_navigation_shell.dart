import 'package:ecommerce_lab/modules/cart/ui/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationShell extends ConsumerWidget {
  const BottomNavigationShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int cartCount = ref.watch(cartProvider).itemCount;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        indicatorColor: const Color(0xFFDEE0FF),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: <NavigationDestination>[
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Color(0xFF24389C)),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: cartCount > 0
                ? Badge.count(
                    count: cartCount,
                    child: const Icon(Icons.shopping_cart_outlined),
                  )
                : const Icon(Icons.shopping_cart_outlined),
            selectedIcon: cartCount > 0
                ? Badge.count(
                    count: cartCount,
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Color(0xFF24389C),
                    ),
                  )
                : const Icon(Icons.shopping_cart, color: Color(0xFF24389C)),
            label: 'Carrito',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Color(0xFF24389C)),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

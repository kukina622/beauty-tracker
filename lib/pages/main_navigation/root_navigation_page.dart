import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/router/router.gr.dart';
import 'package:flutter/material.dart';

class NavigationIcon {
  const NavigationIcon({required this.icon, required this.label, this.activeIcon});
  final IconData icon;
  final String label;
  final IconData? activeIcon;
}

@RoutePage()
class RootNavigationPage extends StatelessWidget {
  const RootNavigationPage({super.key});

  List<NavigationIcon> get navigationIcons => const [
        NavigationIcon(icon: Icons.home_outlined, label: 'Home', activeIcon: Icons.home),
        NavigationIcon(
          icon: Icons.access_time_outlined,
          label: 'Expiring',
          activeIcon: Icons.access_time,
        ),
        NavigationIcon(
          icon: Icons.bar_chart_outlined,
          label: 'Analytics',
          activeIcon: Icons.bar_chart,
        ),
        NavigationIcon(icon: Icons.person_outline, label: 'Profile', activeIcon: Icons.person),
      ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [HomeRoute(), ExpiringSoonRoute(), AnalyticsRoute()],
      floatingActionButton: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF9A9E).withValues(alpha: .3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.white, size: 25),
          onPressed: () {
            AutoRouter.of(context).pushPath('/product/add');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBuilder: (_, tabsRouter) {
        return AnimatedBottomNavigationBar.builder(
          itemCount: navigationIcons.length,
          activeIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          backgroundColor: Colors.white,
          tabBuilder: (index, isActive) {
            final iconData = navigationIcons[index];
            final iconColor = isActive ? const Color(0xFFFF9A9E) : Colors.grey.shade400;
            final icon = (isActive ? iconData.activeIcon : iconData.icon) ?? iconData.icon;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            );
          },
        );
      },
    );
  }
}

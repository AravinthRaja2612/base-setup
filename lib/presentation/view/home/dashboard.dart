import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/application/router/app_router.gr.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_color.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        ChatRoute(),
        SettingRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        // access tabs router
        final tabsRouter = AutoTabsRouter.of(context);
        final currentIndex = tabsRouter.activeIndex;

        return Scaffold(
          backgroundColor: AppColors.surfaceColor(context),
          appBar: AppBar(
            backgroundColor: AppColors.surfaceColor(context),
            elevation: 0,
            centerTitle: true,
            title: Text(
              _getTitle(currentIndex),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primaryColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: tabsRouter.setActiveIndex, // auto_route handles switching
            selectedItemColor: AppColors.primaryColor(context),
            unselectedItemColor: AppColors.textSecondaryColor(context),
            backgroundColor: AppColors.surfaceColor(context),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                activeIcon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Messages';
      case 2:
        return 'Settings';
      default:
        return '';
    }
  }
}

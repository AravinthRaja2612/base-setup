import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_color.dart';


@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});




  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimaryColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Explore your neon dashboard',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryColor(context),
              ),
            ),
            const SizedBox(height: 30),
      
            // Dashboard Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor(context),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primaryColor(context).withOpacity(0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor(context).withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dynamic Theme Active',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimaryColor(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isDark ? 'Dark Mode Enabled' : 'Light Mode Enabled',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryColor(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
      
            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dashboardCard(context, Icons.task_alt, 'Tasks', '12'),
                _dashboardCard(context, Icons.notifications, 'Alerts', '3'),
                _dashboardCard(context, Icons.people, 'Users', '58'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard(BuildContext context, IconData icon, String title, String value) {
    final color = AppColors.primaryColor(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        color: AppColors.surfaceColor(context),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(title, style: textTheme.bodySmall?.copyWith(color: color)),
          Text(value,
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimaryColor(context),
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}

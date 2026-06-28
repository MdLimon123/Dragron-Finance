import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/features/appMain/controller/main_controller.dart';
import 'package:demo_project/app/features/home/view/home_page.dart';
import 'package:demo_project/app/features/loan/view/loan_apply_page.dart';
import 'package:demo_project/app/features/myLoan/view/myloan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';  
import 'package:get/get.dart';
import 'package:demo_project/app/features/notification/view/notification_page.dart';  
import 'package:demo_project/app/features/profile/view/profile_page.dart';  

class AppMainPage extends StatelessWidget {
  const AppMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

  
    final pages = [
       HomePage(), 
      
      LoanApplyPage(),

      MyLoanPage(),

      NotificationPage(),

    ProfilePage(),

      // index 4
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: const _AppBottomNavBar(),
    );
  }
}

class _AppBottomNavBar extends StatelessWidget {
  const _AppBottomNavBar();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();

    final items = <_NavItem>[
      const _NavItem(
        icon: "assets/icon/home.svg",
        activeIcon: "assets/icon/home_active.svg",
        label: 'Home',
      ),
      const _NavItem(
        icon: "assets/icon/add.svg",
        activeIcon: "assets/icon/add_active.svg",
        label: 'Documents',
      ),
      const _NavItem(
        icon: "assets/icon/docs.svg",
        activeIcon: "assets/icon/docs_active.svg",
        label: 'My Loan',
      ),
      const _NavItem(
        icon: "assets/icon/notification.svg",
        activeIcon: "assets/icon/notification_active.svg",
        label: 'Notification',
        hasBadge: true,
      ),
      const _NavItem(
        icon: "assets/icon/user.svg",
        activeIcon: "assets/icon/user_active.svg",
        label: 'Profile',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.activeColor, width: 1.5),
        ),
        //
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Obx(() {
            final current = controller.currentIndex.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isActive = current == index;

                return GestureDetector(
                  onTap: () => controller.onTabTapped(index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.activeColor.withValues(alpha: 0.10)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon with optional notification badge
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SvgPicture.asset(
                              isActive ? item.activeIcon : item.icon,
                              color: isActive
                                  ? AppColors.activeColor
                                  : AppColors.inactiveColor,
                            ),

                            if (item.hasBadge)
                              Obx(() {
                                final count =
                                    controller.notificationCount.value;
                                if (count == 0) return const SizedBox.shrink();
                                return Positioned(
                                  top: -6,
                                  right: -8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFB2C36),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 18,
                                    ),
                                    child: Text(
                                      count > 99 ? '99+' : '$count',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Label
                        Text(
                          item.label,
                          style: TextStyle(
                            color: isActive
                                ? AppColors.activeColor
                                : AppColors.inactiveColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}

// ─── Nav Item Model ─────────────────────────────────────────────────────────────

class _NavItem {
  final String icon;
  final String activeIcon;
  final String label;
  final bool hasBadge;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.hasBadge = false,
  });
}

// ─── Placeholder Page ───────────────────────────────────────────────────────────

class _PlaceholderPage extends StatelessWidget {
  final String label;
  const _PlaceholderPage({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF424242),
        ),
      ),
    );
  }
}

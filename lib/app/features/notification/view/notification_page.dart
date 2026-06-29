import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/features/notification/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshNotifications,
          color: const Color(0xFFA41F13),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller.scrollController,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Page Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Notifications',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF101828),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(() => Text(
                          '${controller.meta.value?.unreadCount ?? 0} unread',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFA41F13),
                          ),
                        )),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.check, size: 16, color: Color(0xFFA41F13)),
                      label: const Text(
                        'Mark all read',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFA41F13),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Section Label
                const Text(
                  'EARLIER',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF99A1AF),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),

                // Notification List Card
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: CircularProgressIndicator(color: Color(0xFFA41F13)),
                      ),
                    );
                  }

                  if (controller.notifications.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          "No notifications found",
                          style: TextStyle(color: Color(0xFF6A7282), fontSize: 16),
                        ),
                      ),
                    );
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppShadow.soft,
                    ),
                    child: Column(
                      children: [
                        ...controller.notifications.asMap().entries.map((entry) {
                          int index = entry.key;
                          var notification = entry.value;
                          bool isLast = index == controller.notifications.length - 1;

                          // Example icons based on type, you can adjust these logic
                          dynamic icon = Icons.notifications_none;
                          Color iconBg = const Color(0xFFF3F4F6);
                          Color iconColor = const Color(0xFF4B5563);
                          
                          if (notification.type == 'kyc_submitted') {
                            icon = 'assets/icon/docs.svg';
                            iconBg = const Color(0xFFFFF7ED);
                            iconColor = const Color(0xFFD97706);
                          } else if (notification.type.contains('approved')) {
                            icon = 'assets/icon/check_mark.svg';
                            iconBg = const Color(0xFFECFDF5);
                            iconColor = const Color(0xFF065F46);
                          } else {
                            // default styling
                            iconBg = const Color(0xFFFBEAE8);
                            iconColor = const Color(0xFFA41F13);
                          }

                          return _buildNotificationItem(
                            icon: icon,
                            iconBg: iconBg,
                            iconColor: iconColor,
                            title: notification.title,
                            desc: notification.message,
                            date: notification.timeAgo.isNotEmpty ? notification.timeAgo : notification.createdAt, // Or format createdAt
                            isUnread: !notification.isRead,
                            isLast: isLast,
                          );
                        }).toList(),
                        if (controller.isFetchingMore.value)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: CircularProgressIndicator(color: Color(0xFFA41F13)),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required dynamic icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String desc,
    required String date,
    required bool isUnread,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: icon is String
                      ? SvgPicture.asset(
                          icon,
                          color: iconColor,
                          width: 20,
                          height: 20,
                        )
                      : Icon(icon as IconData, color: iconColor, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF101828),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF99A1AF),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            desc,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF667085),
                              height: 1.4,
                            ),
                          ),
                        ),
                        if (isUnread)
                          Container(
                            margin: const EdgeInsets.only(left: 12, top: 6),
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFBB4D00),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF2F4F7),
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}
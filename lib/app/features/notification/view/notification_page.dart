import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF101828),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '3 unread',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFA41F13),
                        ),
                      ),
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppShadow.soft,
                ),
                child: Column(
                  children: [
                    _buildNotificationItem(
                      icon: 'assets/icon/tree.svg', 
                      iconBg: const Color(0xFFFBEAE8),
                      iconColor: const Color(0xFFA41F13),
                      title: 'Application Approved!',
                      desc: 'Your home loan application LS-2024-001 has been approved for \$350,000 at 6.75% APR.',
                      date: 'Feb 15, 2024',
                      isUnread: false,
                    ),
                    _buildNotificationItem(
                      icon: 'assets/icon/docs.svg',
                      iconBg: const Color(0xFFFFF7ED),
                      iconColor: const Color(0xFFD97706),
                      title: 'Documents Required',
                      desc: 'Please upload bank statements and tax returns for your home loan application.',
                      date: 'Jan 25, 2024',
                      isUnread: false,
                    ),
                    _buildNotificationItem(
                      icon: 'assets/icon/check_mark.svg',
                      iconBg: const Color(0xFFECFDF5),
                      iconColor: const Color(0xFF065F46),
                      title: 'Application Received',
                      desc: 'Your personal loan application LS-2024-002 is now under review.',
                      date: 'Mar 12, 2024',
                      isUnread: true,
                    ),
                    _buildNotificationItem(
                      icon: Icons.chat_bubble_outline,
                      iconBg: const Color(0xFFF3F4F6),
                      iconColor: const Color(0xFF4B5563),
                      title: 'New Message from Admin',
                      desc: 'Alex Rivera sent you a message regarding your home loan application.',
                      date: 'Mar 14, 2024',
                      isUnread: true,
                    ),
                    _buildNotificationItem(
                      icon: Icons.access_time,
                      iconBg: const Color(0xFFFBEAE8),
                      iconColor: const Color(0xFFA41F13),
                      title: 'Payment Reminder',
                      desc: 'Your next mortgage payment of \$2,270 is due on April 1st.',
                      date: 'Mar 20, 2024',
                      isUnread: true,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
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
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF101828),
                          ),
                        ),
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
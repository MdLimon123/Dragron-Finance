import 'package:flutter/material.dart';
import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:get/get.dart';  
import 'package:demo_project/app/features/liveChat/view/chat_page.dart';
 

class LiveChatPage extends StatelessWidget {
  const LiveChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            const Text(
              'Live Chat',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF292F36),
              ),
            ),
            const SizedBox(height: 21),

            // Subtitle
            const Text(
              'Chat with our support team',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 22),

            // Chat Threads List
            _buildChatCard(
              initials: 'CS',
              name: 'Jordan Mitchell',
              time: '10:30 AM',
              message: "We've received your documents. Review",
              avatarColor: const Color(0xFF6B211E),
              hasOnlineBadge: true,
              unreadCount: 2,
              onTap: () {
              Get.to(()=>ChatPage());   
              },
            ),
            const SizedBox(height: 12),

            _buildChatCard(
              initials: 'SO',
              name: 'Loan Officer - Sarah',
              time: 'Yesterday',
              message: 'Your application looks good! Just need one m',
              avatarColor: const Color(0xFF5C231F),
              hasOnlineBadge: false,
              unreadCount: null,
              onTap: () {},
            ),
            const SizedBox(height: 12),

            _buildChatCard(
              initials: 'DV',
              name: 'Document Verification',
              time: 'Apr 14',
              message: 'Thank you for uploading the documen',
              avatarColor: const Color(0xFF541C18),
              hasOnlineBadge: false,
              unreadCount: null,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatCard({
    required String initials,
    required String name,
    required String time,
    required String message,
    required Color avatarColor,
    required bool hasOnlineBadge,
    required int? unreadCount,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0DBD8), width: 1),
        boxShadow: AppShadow.soft,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Avatar with optional online badge
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Stack(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: avatarColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            initials,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      if (hasOnlineBadge)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00BC7D),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Content Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Name and Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF292F36),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            time,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF9A9490),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Bottom Row: Message Snippet and Optional Unread Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              message,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6A6460),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (unreadCount != null)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0B2E64),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  unreadCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
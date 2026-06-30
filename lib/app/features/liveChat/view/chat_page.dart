import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/features/liveChat/controller/live_chat_controller.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LiveChatController(), permanent: true);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // Header strip (without the 3 dots as requested)
            _buildChatHeader(controller),

            // Chat Messages Area
            Expanded(
              child: Obx(() {
                if (controller.isChatLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.messages.isEmpty) {
                  return const Center(
                    child: Text(
                      'No messages yet. Start the conversation!',
                      style: TextStyle(color: Color(0xFF6B7280)),
                    ),
                  );
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    final isOutgoing = message.sender == null || message.sender?.isAdmin == false;

                    // Format time
                    String timeString = '';
                    try {
                      final DateTime dt = DateTime.parse(message.createdAt).toLocal();
                      timeString = DateFormat('hh:mm a').format(dt);
                    } catch (e) {
                      timeString = '';
                    }

                    return _buildMessageBubble(
                      text: message.message,
                      time: timeString,
                      isOutgoing: isOutgoing,
                    );
                  },
                );
              }),
            ),

            // Admin Typing Indicator
            Obx(() {
              if (controller.isAdminTyping.value) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24.0, bottom: 8.0, top: 4.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Admin is typing...',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF9A9490),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            // Bottom Input Bar
            _buildBottomInputBar(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildChatHeader(LiveChatController controller) {
    return Container(
      padding: const EdgeInsets.symmetric
      (horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      child: Row(
        children: [
          // Back button
          InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back, size: 20, color: Color(0xFF292F36)),
            ),
          ),
          const SizedBox(width: 8),

          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
             
             gradient: LinearGradient(
              colors: [Color(0xFFA41F13), Color(0xFF292F36)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),  

              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "CS",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name and Online Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  controller.currentConversation.value?.admin?.name ?? "Support",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF292F36),
                  ),
                )),
                const SizedBox(height: 2),
                const Text(
                  "Online",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required String text,
    required String time,
    required bool isOutgoing,
  }) {
    return Align(
      alignment: isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isOutgoing ? null : Colors.white,
          gradient: isOutgoing
              ? const LinearGradient(
                  colors: [Color(0xFFA41F13), Color(0xFF292F36)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          borderRadius: BorderRadius.circular(16),
          border: isOutgoing
              ? null
              : Border.all(color: const Color(0xFFE0DBD8), width: 1),
          boxShadow: isOutgoing
              ? [
                  BoxShadow(
                    color: const Color(0xFFA41F13).withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: isOutgoing ? Colors.white : const Color(0xFF292F36),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              time,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: isOutgoing
                    ? Colors.white.withValues(alpha: 0.7)
                    : const Color(0xFF9A9490),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomInputBar(LiveChatController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      child: Row(
        children: [
          // Attachment Icon
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.attach_file,
                color: Color(0xFF6A6460),
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Text Field Container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFAF5F1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0DBD8), width: 1),
              ),
              child: TextField(
                controller: controller.messageController,
                onChanged: controller.onMessageChanged,
                style: const TextStyle(fontSize: 13, color: Color(0xFF292F36)),
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: TextStyle(fontSize: 13, color: Color(0xFF9A9490)),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Send Button
          Material(
            color: const Color(0xFFAD817A),
            shape: const CircleBorder(),
            child: InkWell(
              onTap: controller.sendMessage,
              customBorder: const CircleBorder(),
              child: Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.send_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo_project/app/features/refer/controller/refer_controller.dart';
import 'package:demo_project/app/features/refer/model/referral_model.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class ReferFriendPage extends StatelessWidget {
  ReferFriendPage({super.key});

  final controller = Get.put(ReferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFFA41F13)));
        }

        final data = controller.referralData.value;
        if (data == null) {
          return const Center(
            child: Text("No referral data found", style: TextStyle(color: Color(0xFF6A7282), fontSize: 16)),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshDashboard,
          color: const Color(0xFFA41F13),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header: Back Button & Title
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE0DBD8)),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 16,
                          color: Color(0xFF292F36),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      data.screenTitle.isNotEmpty ? data.screenTitle : 'Refer a Friend',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF292F36),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Main Dark Referral Banner Card
                if (data.hero != null) ...[
                  _buildReferralBanner(data.hero!),
                  const SizedBox(height: 16),
                ],

                // "YOUR REFERRAL CODE" Section
                if (data.referral != null) ...[
                  _buildReferralCodeSection(data.referral!),
                  const SizedBox(height: 16),
                ],

                // "SHARE VIA" Section
                if (data.shareVia != null) ...[
                  _buildShareViaSection(data.shareVia!),
                  const SizedBox(height: 16),
                ],

                // "Referral Progress" Section
                if (data.progress != null) ...[
                  _buildReferralProgressSection(data.progress!, data.referrals),
                  const SizedBox(height: 24),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  // 1. Dark Referral Banner Card
  Widget _buildReferralBanner(ReferralHero hero) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1C2228),
            Color(0xFF292F36),
            Color(0xFFA41F13)
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7A1C14).withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Program Badge & Trophy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset('assets/icon/giftCard.svg'),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    hero.programTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: SvgPicture.asset('assets/icon/trophy.svg'),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Middle Text: Stat
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${hero.totalInvited}-',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFAD89A),
                  ),
                ),
                const TextSpan(
                  text: 'Invited',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          Text(
            hero.subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white60,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          // Bottom Inner Semi-transparent Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.10),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.people_alt_outlined,
                  color: Color(0xFF8EC5FF),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${hero.totalInvited}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Invited',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. "YOUR REFERRAL CODE" Section
  Widget _buildReferralCodeSection(ReferralDetails referral) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE0DBD8)),
        boxShadow: AppShadow.soft,
      ),
      padding: const EdgeInsets.all(21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'YOUR REFERRAL CODE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A6460),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),

          // Code Display Box and Copy Button
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBEAE8),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFA41F13).withValues(alpha: 0.30),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            referral.code,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFA41F13),
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Tap to copy',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFA41F13).withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset('assets/icon/gemime_fill.svg')
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Square Copy Button
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: referral.code));
                  Get.snackbar('Copied', 'Referral code copied to clipboard', snackPosition: SnackPosition.BOTTOM);
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF5F1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE0DBD8)),
                  ),
                  child: const Icon(
                    Icons.copy_all,
                    color: Color(0xFF6A6460),
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Link Display Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F7F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0DBD8)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    referral.link,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9A9490),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),

                // Copy Link Button
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: referral.link));
                    Get.snackbar('Copied', 'Referral link copied to clipboard', snackPosition: SnackPosition.BOTTOM);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFFD1CC)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.copy, size: 12, color: Color(0xFFA41F13)),
                        SizedBox(width: 4),
                        Text(
                          'Copy Link',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFA41F13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. "SHARE VIA" Section
  Widget _buildShareViaSection(ReferralShareVia shareVia) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0DBD8)),
        boxShadow: AppShadow.soft,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SHARE VIA',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9A9490),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),

          // Row of 3 share buttons
          Row(
            children: [
              _buildShareOption(
                icon: Icons.chat_bubble_outline,
                iconBgColor: const Color(0xFFE8FDF5),
                iconColor: const Color(0xFF00BC7D),
                label: 'WhatsApp',
                onTap: () async {
                  final url = Uri.parse(shareVia.whatsapp);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    Get.snackbar('Error', 'Could not launch WhatsApp');
                  }
                },
              ),
              const SizedBox(width: 10),
              _buildShareOption(
                icon: Icons.mail_outline,
                iconBgColor: const Color(0xFFFFF0EE),
                iconColor: const Color(0xFFA41F13),
                label: 'Email',
                onTap: () async {
                  final url = Uri.parse(shareVia.email);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    Get.snackbar('Error', 'Could not launch Email app');
                  }
                },
              ),
              const SizedBox(width: 10),
              _buildShareOption(
                icon: Icons.share_outlined,
                iconBgColor: const Color(0xFFF5F2F0),
                iconColor: const Color(0xFF6A6460),
                label: 'Share',
                onTap: () {
                  Share.share(shareVia.shareText);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShareOption({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE0DBD8)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF292F36),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 4. "Referral Progress" Section
  Widget _buildReferralProgressSection(ReferralProgress progress, List<ReferralUser> referrals) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0DBD8)),
        boxShadow: AppShadow.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.people_outline,
                      color: Color(0xFFA41F13),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      progress.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF292F36),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${progress.goal} total',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9A9490),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),

          // Progress Bar and Percentages
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${progress.joined} joined of ${progress.invited} invited',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6A6460),
                      ),
                    ),
                    Text(
                      '${progress.percentage}%',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFA41F13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Linear Progress Indicator
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: SizedBox(
                    height: 6,
                    child: LinearProgressIndicator(
                      value: progress.percentage / 100.0,
                      backgroundColor: const Color(0xFFF5E6E4),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFA41F13),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Star text row
                Row(
                  children: [
                    const Icon(
                      Icons.star_border,
                      color: Color(0xFFFFB800),
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      progress.remainingText,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9A9490),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Users List
          if (referrals.isNotEmpty) ...referrals.map((user) {
            Color statusColor;
            Color avatarColor;
            if (user.status.toLowerCase().contains('joined') || user.status.toLowerCase().contains('active')) {
              statusColor = const Color(0xFF00BC7D);
              avatarColor = const Color(0xFF00766C); // Example dynamic approach
            } else if (user.status.toLowerCase().contains('pending')) {
              statusColor = const Color(0xFFF57C00);
              avatarColor = const Color(0xFFB45309);
            } else {
              statusColor = const Color(0xFF9A9490);
              avatarColor = const Color(0xFF6A6460);
            }

            return _buildUserRow(
              initials: user.initials,
              avatarColor: avatarColor, // You could randomize this or derive from name hash
              name: user.name,
              date: user.date,
              statusText: user.status,
              statusColor: statusColor,
              isTopBorder: true,
            );
          }).toList() else const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("No referrals yet", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildUserRow({
    required String initials,
    required Color avatarColor,
    required String name,
    required String date,
    required String statusText,
    required Color statusColor,
    required bool isTopBorder,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: isTopBorder
            ? const Border(
                top: BorderSide(color: Color(0xFFF5F2F0), width: 1),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar Circle
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: avatarColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initials.isNotEmpty ? initials : name.substring(0, 1),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name and Date Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF292F36),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9A9490),
                  ),
                ),
              ],
            ),
          ),

          // Status Indicator Dot and Text
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                statusText,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

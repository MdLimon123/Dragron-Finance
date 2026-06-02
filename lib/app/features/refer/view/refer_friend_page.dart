import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReferFriendPage extends StatelessWidget {
  const ReferFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
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
                const Text(
                  'Refer a Friend',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF292F36),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Main Dark Referral Banner Card
            _buildReferralBanner(),
            const SizedBox(height: 16),

            // "YOUR REFERRAL CODE" Section
            _buildReferralCodeSection(),
            const SizedBox(height: 16),

            // "SHARE VIA" Section
            _buildShareViaSection(),
            const SizedBox(height: 16),

            // "Referral Progress" Section
            _buildReferralProgressSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // 1. Dark Referral Banner Card
  Widget _buildReferralBanner() {
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
                    child:SvgPicture.asset('assets/icon/giftCard.svg') 
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Referral Program',
                    style: TextStyle(
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
                child:SvgPicture.asset('assets/icon/trophy.svg')  
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Middle Text: "12-Invited" Stat
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: '12-',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFAD89A),
                  ),
                ),
                TextSpan(
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

          const Text(
            'Please recommend us to your\nfriends, family & colleagues.',
            style: TextStyle(
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
                  children: const [
                    Text(
                      '12',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
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
  Widget _buildReferralCodeSection() {
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
                      color: const Color(0xFFA41F13)
                      .withValues(alpha: 0.30  ),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'JHBJB200',
                            style: TextStyle(
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
                              color: const Color(0xFFA41F13)
                              .withValues(
                                alpha: 0.7,
                              ),
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
                onTap: () {},
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
                const Expanded(
                  child: Text(
                    'https://loansphere.app/ref...',
                    style: TextStyle(
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
                  onTap: () {},
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
  Widget _buildShareViaSection() {
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
                onTap: () {},
              ),
              const SizedBox(width: 10),
              _buildShareOption(
                icon: Icons.mail_outline,
                iconBgColor: const Color(0xFFFFF0EE),
                iconColor: const Color(0xFFA41F13),
                label: 'Email',
                onTap: () {},
              ),
              const SizedBox(width: 10),
              _buildShareOption(
                icon: Icons.share_outlined,
                iconBgColor: const Color(0xFFF5F2F0),
                iconColor: const Color(0xFF6A6460),
                label: 'Share',
                onTap: () {},
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
  Widget _buildReferralProgressSection() {
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
                  children: const [
                    Icon(
                      Icons.people_outline,
                      color: Color(0xFFA41F13),
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Referral Progress',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF292F36),
                      ),
                    ),
                  ],
                ),
                const Text(
                  '5 total',
                  style: TextStyle(
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
                  children: const [
                    Text(
                      '2 joined of 5 invited',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6A6460),
                      ),
                    ),
                    Text(
                      '40%',
                      style: TextStyle(
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
                      value: 0.4,
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
                  children: const [
                    Icon(
                      Icons.star_border,
                      color: Color(0xFFFFB800),
                      size: 12,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '3 more joined',
                      style: TextStyle(
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
          _buildUserRow(
            initials: 'MJ',
            avatarColor: const Color(0xFF00766C),
            name: 'Mike Johnson',
            date: 'Apr 12, 2026',
            statusText: 'Joined & Active',
            statusColor: const Color(0xFF00BC7D),
            isTopBorder: true,
          ),
          _buildUserRow(
            initials: 'PS',
            avatarColor: const Color(0xFF0B2E64),
            name: 'Priya Sharma',
            date: 'Mar 28, 2026',
            statusText: 'Joined & Active',
            statusColor: const Color(0xFF00BC7D),
            isTopBorder: true,
          ),
          _buildUserRow(
            initials: 'TW',
            avatarColor: const Color(0xFFB45309),
            name: 'Tom Wilson',
            date: 'Apr 17, 2026',
            statusText: 'Pending',
            statusColor: const Color(0xFFF57C00),
            isTopBorder: true,
          ),
          _buildUserRow(
            initials: 'LH',
            avatarColor: const Color(0xFF7C3AED),
            name: 'Layla Hassan',
            date: 'Apr 15, 2026',
            statusText: 'Pending',
            statusColor: const Color(0xFFF57C00),
            isTopBorder: true,
          ),
          _buildUserRow(
            initials: 'CR',
            avatarColor: const Color(0xFF6A6460),
            name: 'Carlos Reyes',
            date: 'Apr 18, 2026',
            statusText: 'Invited',
            statusColor: const Color(0xFF9A9490),
            isTopBorder: true,
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
                initials,
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

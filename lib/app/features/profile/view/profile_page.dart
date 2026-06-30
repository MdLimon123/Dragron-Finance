import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/features/profile/view/personal_info_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';  
import 'package:demo_project/app/features/profile/controller/profile_controller.dart';


class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final profile = controller.profileData.value;
          if (profile == null) {
            return const Center(child: Text("No profile data found"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101828),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Manage your account information',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF99A1AF),
                ),
              ),
              const SizedBox(height: 24),

              // Profile Card
              _buildProfileCard(profile),
              const SizedBox(height: 24),

              // Personal Information
              _buildSectionCard(
                title: 'Personal Information',
                icon: Icons.person_outline,
                showEdit: true,
                children: [
                  _buildInfoField('Full Name', profile.fullName, icon: Icons.person_outline),
                  _buildInfoField('Email Address', profile.emailAddress, icon: Icons.mail_outline, isLast: true),
                ],
              ),
              const SizedBox(height: 20),

              // Contact Details
              _buildSectionCard(
                title: 'Contact Details',
                icon: Icons.phone_outlined,
                children: [
                  _buildInfoField('Phone Number', profile.phoneNumber ?? 'Not provided', icon: Icons.phone_outlined),
                  _buildInfoField('Address', profile.location ?? 'Not provided', icon: Icons.location_on_outlined, isLast: true),
                ],
              ),
              const SizedBox(height: 20),

              // Account & Security
              _buildSectionCard(
                title: 'Account & Security',
                icon: Icons.shield_outlined,
                children: [
                  _buildAccountRow('Account Status', profile.isActive ? 'Active' : 'Inactive', isBadge: true),
                  _buildAccountRow('Member Since', 'January 2024'), // Assuming API doesn't return this yet
                  _buildAccountRow('Two-Factor Auth', 'Enabled', isBadge: true, isLast: true),
                ],
              ),
              const SizedBox(height: 32),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Show confirmation dialog before logging out
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Log out'),
                        content: const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back(); // close dialog
                              controller.logout();
                            },
                            child: const Text('Log out', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withValues(alpha: 0.1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.red.withValues(alpha: 0.3)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
        }),
      ),
    );
  }

  Widget _buildProfileCard(var profile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF7A1710), Color(0xFFA41F13)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: AppShadow.soft,
      ),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: (profile.profileImageUrl != null && profile.profileImageUrl!.isNotEmpty)
                  ? Image.network(
                      profile.profileImageUrl!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Image.asset('assets/image/food.jpg', fit: BoxFit.cover),
                    )
                  : Image.asset('assets/image/food.jpg', fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 20),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.fullName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  profile.emailAddress,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white60,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStatusBadge(
                      label: profile.isActive ? 'Active Account' : 'Inactive Account',
                      icon: Icons.circle,
                      iconColor: profile.isActive ? const Color(0xFF22C55E) : Colors.red,
                    ),
                    const SizedBox(width: 3),
                    _buildStatusBadge(
                      label: profile.roleLabel,
                      icon: Icons.shield_outlined,
                      iconColor: Colors.white,
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

  Widget _buildStatusBadge({required String label, required IconData icon, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.20),
        borderRadius: BorderRadius.circular(37),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: icon == Icons.circle ? 8 : 14, color: iconColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    bool showEdit = false,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadow.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 20, color: const Color(0xFF99A1AF)),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF101828),
                      ),
                    ),
                  ],
                ),
                if (showEdit)
                  TextButton.icon(
                    onPressed: () {
                        Get.to(() => const PersonalInfoPage()); 
                    },
                    icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFFA41F13)),
                    label: const Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFA41F13),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value, {required IconData icon, bool isLast = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16, color: const Color(0xFFD0D5DD)),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF99A1AF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF101828),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, thickness: 1, color: Color(0xFFF2F4F7), indent: 20, endIndent: 20),
      ],
    );
  }

  Widget _buildAccountRow(String label, String value, {bool isBadge = false, bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Color(0xFF667085)),
              ),
              if (isBadge)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF065F46),
                    ),
                  ),
                )
              else
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF101828),
                  ),
                ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, thickness: 1, color: Color(0xFFF2F4F7), indent: 20, endIndent: 20),
      ],
    );
  }
}
import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/features/profile/controller/profile_controller.dart';
import 'package:demo_project/app/features/profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Obx(() {
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

              // Profile Card (reused from ProfilePage)
              _buildProfileCard(profile),
              const SizedBox(height: 24),

              // Editable Personal Information Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppShadow.soft,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
                      child: Row(
                        children: [
                          Icon(Icons.person_outline, size: 20, color: Color(0xFF99A1AF)),
                          SizedBox(width: 10),
                          Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF101828),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Full Name Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.person_outline, size: 16, color: Color(0xFFD0D5DD)),
                              SizedBox(width: 8),
                              Text(
                                'Full Name',
                                style: TextStyle(fontSize: 12, color: Color(0xFF99A1AF)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBEAE8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFA41F13).withOpacity(0.2)),
                            ),
                            child: TextField(
                              controller: controller.fullNameController,
                              decoration: const InputDecoration(
                                hintText: 'Enter full name',
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF101828),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email Address (Static in this view as per design)
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.mail_outline, size: 16, color: Color(0xFFD0D5DD)),
                              SizedBox(width: 8),
                              Text(
                                'Email Address',
                                style: TextStyle(fontSize: 12, color: Color(0xFF99A1AF)),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                              profile.emailAddress,
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
                    const SizedBox(height: 24),

                    // Save Changes Button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: GestureDetector(
                        onTap: () {
                          if (!controller.isUpdating.value) {
                            controller.updateProfileData();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA41F13),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Obx(() => controller.isUpdating.value
                              ? const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                  ),
                                )
                              : const Text(
                                  'Save Changes',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Contact Details (Full Details)
              _buildSectionCard(
                title: 'Contact Details',
                icon: Icons.phone_outlined,
                children: [
                  _buildInfoField('Phone Number', controller.phoneController, icon: Icons.phone_outlined),
                  _buildInfoField('Address', controller.addressController, icon: Icons.location_on_outlined, isLast: true),
                ],
              ),
              const SizedBox(height: 20),

              // Account & Security (Full Details)
              _buildSectionCard(
                title: 'Account & Security',
                icon: Icons.shield_outlined,
                children: [
                  _buildAccountRow('Account Status', profile.isActive ? 'Active' : 'Inactive', isBadge: true),
                  _buildAccountRow('Member Since', 'January 2024'),
                  _buildAccountRow('Two-Factor Auth', 'Enabled', isBadge: true, isLast: true),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
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
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, TextEditingController textController, {required IconData icon, bool isLast = false}) {
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
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFBEAE8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFA41F13).withOpacity(0.2)),
                ),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Enter $label',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
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

  Widget _buildProfileCard(ProfileModel profile) {
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
          GestureDetector(
            onTap: () => Get.find<ProfileController>().pickProfileImage(),
            child: Stack(
              children: [
                Obx(() {
                  final controller = Get.find<ProfileController>();
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: controller.selectedProfileImage.value != null
                          ? Image.file(
                              controller.selectedProfileImage.value!,
                              fit: BoxFit.cover,
                            )
                          : (profile.profileImageUrl != null && profile.profileImageUrl!.isNotEmpty)
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
                  );
                }),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA41F13),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.edit, size: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.fullName,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                Text(
                  profile.emailAddress,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white60),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStatusBadge(profile.isActive ? 'Active Account' : 'Inactive Account', Icons.circle, profile.isActive ? const Color(0xFF22C55E) : Colors.red),
                    const SizedBox(width: 3),
                    _buildStatusBadge(profile.roleLabel, Icons.shield_outlined, Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String label, IconData icon, Color iconColor) {
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
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
        ],
      ),
    );
  }
}
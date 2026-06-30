import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/features/e-sign-agreement/view/all_esign_agreement.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
 
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:demo_project/app/features/profile/controller/profile_controller.dart';
import 'package:demo_project/app/features/notification/view/notification_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// The heading container with greeting, date and notification
              Obx(() => _headingContainer()),
              SizedBox(height: 24),
              Text(
                "Active Applications",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101828),
                ),
              ),
              SizedBox(height: 12),

              _activeApplication(),
              SizedBox(height: 24),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101828),
                ),
              ),
              SizedBox(height: 12),

              SizedBox(
                height: 109,
                child: ListView(
                  scrollDirection: Axis.horizontal,

                  children: [
                    _quickActionItem(
                      onTap: () {
                        // Handle New Loan action
                      },
                      icon: 'assets/icon/add_fill.svg',
                      title: 'New Loan',
                      iconColor: Color(0xFFA41F13),
                      iconBgColor: Color(0xFFFBEAE8),
                    ),

                    SizedBox(width: 8),
                    _quickActionItem(
                      onTap: () {
                        Get.toNamed(AppRoutes.coApplication);
                      },
                      icon: 'assets/icon/person_add.svg',
                      title: 'Invite Co-Applicant',
                      iconColor: Color(0xFF292F36),
                      iconBgColor: Color(0xFFEDE8E4),
                    ),
                    SizedBox(width: 8),
                    _quickActionItem(
                      onTap: () {
                        Get.toNamed(AppRoutes.bookCall);
                      },
                      icon: 'assets/icon/calender.svg',
                      title: 'Chat Now',
                      iconColor: Color(0xFF065F46),
                      iconBgColor: Color(0xFFECFDF5),
                    ),
                    SizedBox(width: 8),
                    _quickActionItem(
                      onTap: () {
                        // Handle Upload Docs action
                      },
                      icon: 'assets/icon/upload.svg',
                      title: 'Upload Docs',
                      iconColor: Color(0xFF292F36),
                      iconBgColor: Color(0xFFE6E1DE),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
              Text(
                "More Actions",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101828),
                ),
              ),
              SizedBox(height: 12),

              SizedBox(
                height: 109,
                child: ListView(
                  scrollDirection: Axis.horizontal,

                  children: [
                    _quickActionItem(
                      onTap: () {
                        Get.toNamed(AppRoutes.kycVerify);
                      },
                      icon: 'assets/icon/scan.svg',
                      title: 'KYC Verify',
                      iconColor: Color(0xFF1C3A5C),
                      iconBgColor: Color(0xFFE0E9F5),
                    ),

                    SizedBox(width: 8),
                    _quickActionItem(
                      onTap: () {
                        Get.to(()=> AllEsignAgreement());
                      },
                      icon: 'assets/icon/e-sign.svg',
                      title: 'E-Sign',
                      iconColor: Color(0xFF7A1710),
                      iconBgColor: Color(0xFFF3E8E7),
                    ),
                    SizedBox(width: 8),
                    _quickActionItem(
                      onTap: () {
                        Get.to(() => NotificationPage());
                      },
                      icon: 'assets/icon/notification.svg',
                      title: 'Alerts',
                      iconColor: Color(0xFFB45309),
                      iconBgColor: Color(0xFFFFFBEB),
                    ),
                    SizedBox(width: 8),
                    _quickActionItem(
                      onTap: () {
                        Get.toNamed(AppRoutes.referFriend);   
                      },
                      icon: 'assets/icon/refer.svg',
                      title: 'Refer',
                      iconColor: Color(0xFF7C3AED),
                      iconBgColor: Color(0xFFF5F0FE),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    "Recent Loans",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF101828),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // View all action
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF155DCF),
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icon/next.svg',
                    color: Color(0xFF155DFC),
                  ),
                ],
              ),

              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 75,
                    padding: const EdgeInsets.all(11.1),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border(
                        top: BorderSide(
                          color: const Color(0xFFF3F4F6),
                          width: 1.11,
                        ),
                      ),
                      boxShadow: [
                        // Shadow 1
                        BoxShadow(
                          color: const Color(
                            0xFF000000,
                          ).withValues(alpha: 0.10),
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                          spreadRadius: -1,
                        ),
                        // Shadow 2
                        BoxShadow(
                          color: const Color(
                            0xFF000000,
                          ).withValues(alpha: 0.10),
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        // Icon
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.home_outlined,
                            color: Color(0xFF155DFC),
                            size: 18,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Title and subtitle
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Homeowner Loan',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF101828),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'LS-2024-001',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF99A1AF),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Amount and status
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '£350,000',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF101828),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(37),
                              ),
                              child: const Text(
                                'Approved',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF008236),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activeApplication() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(17.1, 17.1, 17.1, 11.1),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border(
          top: BorderSide(color: const Color(0xFFF3F4F6), width: 1.11),
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // Shadow 1
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.10),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: -1,
          ),
          // Shadow 2
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.10),
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Row(
            children: [
              // Icon container
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/icon/user.svg',
                    color: Color(0xFF155DFC),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Loan title and reference
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Homeowner Loan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF101828),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'LS-2024-002',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF99A1AF),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C6),
                  borderRadius: BorderRadius.circular(37),
                ),
                child: const Text(
                  'Under Review',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFBB4D00),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Amount and date section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '£20,000',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101828),
                ),
              ),
              Text(
                'Mar 10, 2024',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF99A1AF),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Progress section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Application Progress',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF99A1AF),
                ),
              ),
              const Text(
                '40%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF99A1AF),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.4,
              backgroundColor: Color(0xFFF3F4F6),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2B7FFF)),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _headingContainer() {
    final profile = profileController.profileData.value;
    final firstName = profile?.fullName ?? 'User';


    var hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good morning,';
    } else if (hour < 17) {
      greeting = 'Good afternoon,';
    } else {
      greeting = 'Good evening,';
    }

    String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 24),
      width: double.infinity,

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7A1710), Color(0xFFA41F13), Color(0xFFC12518)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting text
          Text(
            greeting,
            style: TextStyle(
              color: Color(0xFFFFFFFF).withValues(alpha: 0.75),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 5),

          // Name with emoji
          Text(
            '$firstName ',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          // Date
          Text(
            formattedDate,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 15),

          // Notification button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFB900),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '3 unread notifications',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.90),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickActionItem({
    required String icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: 84,
        height: 109,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
          border: Border(
            top: BorderSide(color: const Color(0xFFF3F4F6), width: 1.11),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withValues(alpha: 0.08),
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(icon, color: iconColor),
              ),
            ),
            const SizedBox(height: 8),
            // Label
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
                height: 1.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

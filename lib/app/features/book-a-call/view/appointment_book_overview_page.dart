import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:demo_project/app/features/book-a-call/controller/bookcall_controller.dart';

class AppointmentBookOverviewPage extends StatelessWidget {
  AppointmentBookOverviewPage({super.key});

  final BookCallController controller = Get.find<BookCallController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: AppShadow.soft,
            border: Border.all(color: const Color(0xFFE0DBD8), width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success concentric Checkmark Icon
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8FDF5),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFC3EFE0),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF00BC7D),
                        width: 3.0,
                      ),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Color(0xFF00BC7D),
                      size: 24,
                      weight: 700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Title
              const Text(
                'Appointment Booked!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF292F36),
                ),
              ),
              const SizedBox(height: 12),

              // Subtitle
              Builder(
                builder: (context) {
                  final callType = controller.bookCallData.value?.selected?.callTypeLabel ?? "Voice Call";
                  final managerName = controller.bookCallData.value?.caseManager?.name ?? "Jordan Mitchell";
                  final names = managerName.split(" ");
                  final firstName = names.isNotEmpty ? names.first : managerName;
                  final lastName = names.length > 1 ? names.sublist(1).join(" ") : "";
                  final nameSpan = lastName.isNotEmpty ? '$firstName\n$lastName' : firstName;
                  
                  return RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Your $callType with ',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6A6460),
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: nameSpan,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF292F36),
                          ),
                        ),
                        const TextSpan(
                          text: ' is confirmed.',
                        ),
                      ],
                    ),
                  );
                }
              ),
              const SizedBox(height: 32),

              // Details Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF5F1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE0DBD8),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      Icons.calendar_month_outlined,
                      controller.bookCallData.value?.selected?.dateLabel ?? 'Thu, April 30, 2026',
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      Icons.access_time_rounded,
                      controller.selectedTime.value ?? '10:00 AM',
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      Icons.person_outline_rounded,
                      controller.bookCallData.value?.caseManager?.name ?? 'Jordan Mitchell',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Reminder Note Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9EA),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFFBE8CC),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.notifications_none_rounded,
                      size: 18,
                      color: Color(0xFFD97706),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        controller.bookCallData.value?.reminder?.message ?? "You'll receive a reminder notification 30 minutes before your appointment.",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFB46300),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Back to Dashboard Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFA41F13), Color(0xFF7A1710)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFA41F13).withValues(alpha: 0.30),
                      offset: const Offset(0, 4),
                      blurRadius: 24,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Get.offAllNamed(AppRoutes.mainPage);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Back to Dashboard',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFFFBEAE8),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: const Color(0xFFA41F13),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF292F36),
            ),
          ),
        ),
      ],
    );
  }
}
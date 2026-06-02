import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnderReviewPage extends StatelessWidget {
  const UnderReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),

            SizedBox(height: 24),

            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.all(33),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE0DBD8)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withValues(alpha: 0.10),
                      offset: const Offset(0, 1),
                      blurRadius: 1.96,
                      spreadRadius: -0.98,
                    ),
                    BoxShadow(
                      color: const Color(0xFF000000).withValues(alpha: 0.10),
                      offset: const Offset(0, 1),
                      blurRadius: 2.94,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Clock Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF59E0B).withValues(alpha: 0.06),
                            offset: Offset(0, 0),
                          ),

                          BoxShadow(
                            color: Color(0xFFFFFBEB),
                            offset: Offset(0, 0),
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.access_time_rounded,
                          color: Color(0xFFFE9A00),
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    const Text(
                      'Under Review',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF292F36),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Subtitle
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6A6460),
                          fontWeight: FontWeight.w400,
                          height: 1.55,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'Your documents have been submitted and are being reviewed by ',
                          ),
                          TextSpan(
                            text: 'Dragon Finance',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF292F36),
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 46),

                    // Pending Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: const Color(0xFFFEE685),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                          const Text(
                            'Pending Verification',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFBB4D00),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Check Rows
                    _buildCheckRow('Document authenticity'),
                    const SizedBox(height: 10),
                    _buildCheckRow('Facial match'),
                    const SizedBox(height: 53),

                    // CTA Button
                    Container(
                      width: double.infinity,
                      height: 51,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFA41F13), Color(0xFF7A1710)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFA41F13,
                            ).withValues(alpha: 0.30),
                            offset: const Offset(0, 4),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Return to Dashboard',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('→', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFE0DBD8), width: 1.08),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF000000).withValues(alpha: 0.10),
                  offset: const Offset(0, 1),
                  blurRadius: 1.96,
                  spreadRadius: -0.98,
                ),
                BoxShadow(
                  color: Color(0xFF000000).withValues(alpha: 0.10),
                  offset: const Offset(0, 1),
                  blurRadius: 2.94,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: Color(0xFF292F36),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Identity Verification',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF292F36),
              ),
            ),

            Text(
              'KYC — Know Your Customer',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6A6460),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckRow(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFFFAF5F1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0DBD8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF292F36),
            ),
          ),
          const Row(
            children: [
              Icon(
                Icons.radio_button_unchecked,
                size: 16,
                color: Color(0xFFFFB900),
              ),
              SizedBox(width: 6),
              Text(
                'Checking',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFE17100),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

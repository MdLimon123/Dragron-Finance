import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/features/KYC-Verify/view/check_selfie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class IdentityVerification extends StatelessWidget {
  const IdentityVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress Steps
                    _buildProgressSteps(),
                    const SizedBox(height: 20),
                    // Security Banner
                    _buildSecurityBanner(),
                    const SizedBox(height: 20),
                    // Document Type
                    _buildDocumentType(),
                    const SizedBox(height: 20),
                    // Upload ID Photos
                    _buildUploadPhotos(),
                    const SizedBox(height: 16),
                    // Tips Section
                    _buildTipsSection(),
                    const SizedBox(height: 24),
                    // Continue Button
                    _buildContinueButton(),
                    const SizedBox(height: 16),
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



  Widget _buildProgressSteps() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
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
      child: Image.asset('assets/image/step1.png'),
    );
  }



  Widget _buildSecurityBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF292F36),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: SvgPicture.asset(
              'assets/icon/secure.svg',
              width: 16,
              height: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '256-bit Encrypted',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Your data is secure and never shared',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.60),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFF00BC7D).withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(37),
              border: Border.all(
                color: Color(0xFF00BC7D).withValues(alpha: 0.30),
                width: 1.08,
              ),
            ),
            child: const Text(
              'Secure',
              style: TextStyle(
                color: Color(0xFF00D492),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildDocumentType() {
    return Container(
      padding: const EdgeInsets.all(21),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DOCUMENT TYPE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A6460),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildDocTypeButton('Driving License', true)),
              const SizedBox(width: 10),
              Expanded(child: _buildDocTypeButton('Passport', false)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocTypeButton(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFBEAE8) : Color(0xFFFAF5F1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Color(0xFFA41F13) : Color(0xFFE0DBD8),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? Color(0xFFA41F13) : Color(0xFF6A6460),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadPhotos() {
    return Container(
      padding: const EdgeInsets.all(21),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UPLOAD ID PHOTOS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A6460),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildUploadCard(
            'Front Side',
            'Clear photo of the front of your ID',
            Icons.description_outlined,
          ),
          const SizedBox(height: 10),
          _buildUploadCard(
            'Back Side',
            'Clear photo of the back of your ID',
            Icons.flip_camera_android_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildUploadCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFAF5F1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE0DBD8), width: 1.08),
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFE0DBD8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF292F36),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9A9490),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/icon/upload_fill.svg"),
              const SizedBox(width: 6),
              Text(
                'Tap to upload',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFA41F13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipsSection() {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TIPS FOR A GOOD SCAN',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A6460),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          _buildTipItem(
            "assets/icon/visibility.svg",
            'All text and photo must be clearly visible',
          ),
          _buildTipItem(
            "assets/icon/gemmin.svg",
            'Use good lighting, avoid shadows and glare',
          ),
          _buildTipItem(
            "assets/icon/docs.svg",
            'Place ID on a dark flat surface for contrast',
          ),
          _buildTipItem(
            "assets/icon/excilomatory.svg",
            'Expired documents will not be accepted',
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(0xFFFAF5F1),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFE0DBD8), width: 1.08),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(icon, width: 16, height: 16),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6A6460),
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {

    return Container(
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
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Get.to(() => const CheckSelfiePage());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Continue to Selfie',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 18, color: Colors.white),
            ],
          ),
        ),
      ),
    );
 
 
  }
}

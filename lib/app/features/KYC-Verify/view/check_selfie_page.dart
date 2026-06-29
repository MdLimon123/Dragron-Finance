
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/features/KYC-Verify/view/under_review_page.dart';
import 'package:demo_project/app/features/KYC-Verify/controller/kyc_verify_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CheckSelfiePage extends StatelessWidget {
  const CheckSelfiePage({super.key});

  @override
  Widget build(BuildContext context) {
    final KycVerifyController controller = Get.find<KycVerifyController>();
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildProgressSteps(),
                    const SizedBox(height: 24),
                    _buildSecurityBanner(),
                    SizedBox(height: 20),

                    _selfieVerification(controller),
                    SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFE0DBD8),
                          width: 1.08,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 2,
                            spreadRadius: -1,
                            offset: const Offset(0, 1),
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 3,

                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'SELFIE GUIDELINES',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6A6460),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: _buildGuidelineBox(
                                    icon: "assets/icon/check_mark.svg",
                                    iconColor: const Color(0xFF10B981),
                                    backgroundColor: const Color(0xFFECFDF5),
                                    borderColor: const Color(
                                      0xFFD0FAE5,
                                    ).withValues(alpha: 0.30),
                                    text: 'Face fully visible and centred',
                                    isPositive: true,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildGuidelineBox(
                                    icon: "assets/icon/check_mark.svg",
                                    iconColor: const Color(0xFF00BC7D),
                                    backgroundColor: const Color(0xFFECFDF5),
                                    borderColor: const Color(
                                      0xFFD0FAE5,
                                    ).withValues(alpha: 0.30),
                                    text: 'Well lit, neutral background',
                                    isPositive: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: _buildGuidelineBox(
                                    icon: "assets/icon/closed.svg",
                                    iconColor: const Color(0xFFA41F13),
                                    backgroundColor: const Color(0xFFFEE2E2),
                                    borderColor: const Color(
                                      0xFFFFE2E2,
                                    ).withValues(alpha: 0.30),
                                    text: 'No sunglasses or hats',
                                    isPositive: false,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildGuidelineBox(
                                    icon: "assets/icon/closed.svg",
                                    iconColor: const Color(0xFFA41F13),
                                    backgroundColor: const Color(0xFFFEE2E2),
                                    borderColor: const Color(
                                      0xFFFFE2E2,
                                    ).withValues(alpha: 0.30),
                                    text: 'Do not crop or edit the photo',
                                    isPositive: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),
                    _buildContinueButton(controller),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selfieVerification(KycVerifyController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
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

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SELFIE VERIFICATION',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A6460),
            ),
          ),

          SizedBox(height: 16),
          GestureDetector(
            onTap: controller.pickSelfieFromCamera,
            child: Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 34),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF1C2228),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE0DBD8), width: 1.08),
              ),
              child: controller.selfieImage.value != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      controller.selfieImage.value!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF).withValues(alpha: 0.10),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: SvgPicture.asset('assets/icon/camera.svg'),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Tap to open camera',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF).withValues(alpha: 0.70),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          'or upload a selfie photo',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFFFF).withValues(alpha: 0.40),
                          ),
                        ),
                      ),
                    ],
                  ),
            )),
          ),

          SizedBox(height: 16),

          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Color(0xFFFBEAE8),
              border: Border.all(
                color: Color(0xFFA41F13).withValues(alpha: 0.30),
                width: 1.08,
              ),

              borderRadius: BorderRadius.circular(16),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: controller.pickSelfieFromGallery,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icon/upload_fill.svg'),
                    SizedBox(width: 6),
                    Text(
                      ' Upload Photo Instead',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFA41F13),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ),

          // Additional content can be added here
        ],
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
      child: Image.asset('assets/image/step2.png'),
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

  Widget _buildGuidelineBox({
    required String icon,
    required Color iconColor,
    required Color backgroundColor,
    required Color borderColor,
    required String text,
    required bool isPositive,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.08),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
            child: SvgPicture.asset(icon),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isPositive
                    ? const Color(0xFF065F46)
                    : const Color(0xFF991B1B),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(KycVerifyController controller) {
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
            controller.uploadSelfie();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => controller.isLoading.value
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : SvgPicture.asset('assets/icon/star.svg')),
              SizedBox(width: 6),
              Obx(() => controller.isLoading.value
                  ? const SizedBox.shrink()
                  : const Text(
                      ' Submit for Verification',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }


}

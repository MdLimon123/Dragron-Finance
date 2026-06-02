import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/core/widget/custom_button.dart'; 
import 'package:demo_project/app/features/loan/view/upload_document_page.dart';  
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationSubmitted extends StatelessWidget {
  const ApplicationSubmitted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCFCE7),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Color(0xFF00A63E),
                    size: 48,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Title
              const Text(
                'Application Submitted!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101828),
                ),
              ),
              const SizedBox(height: 16),

              // Application Number Section
              const Text(
                'Your application number is',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6A7282),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBEAE8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'LS-2024-868',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFA41F13),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Status Message
              const Text(
                "We'll review your application and contact you shortly.\nYou can track the status in My Loan.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF99A1AF),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),

              // Action Buttons Row
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () {},
                      text: 'View My Loan',
                      color: const Color(0xFFA41F13),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      onTap: () {},
                      text: 'Call Us Now',
                      color: const Color(0xFFA41F13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Upload Documents Button
              CustomButton(
                onTap: () {
                    Get.to(() => const UploadDocumentPage());
                },
                text: 'Upload Documents',
                color: const Color(0xFFA41F13),
                icon: const Icon(Icons.file_upload_outlined, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 16),

              // Invite Co-Applicant Button
              CustomButton(
                onTap: () {},
                text: 'Invite Co-Applicant',
                color: const Color(0xFFA41F13),
              ),
              const SizedBox(height: 32),

              // Footer Text
              const Text(
                'Please upload your documents to progress your application and receive your funds. If the property is jointly owned, please invite your co-applicant.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF99A1AF),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

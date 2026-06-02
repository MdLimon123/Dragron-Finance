import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:demo_project/app/features/loan/view/application_submitted.dart';    
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanApplyStep5 extends StatelessWidget {
  const LoanApplyStep5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Apply for a Loan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101828),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Complete all steps to submit your application',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF99A1AF),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 24),
              _buildStepIndicator(),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: AppShadow.soft,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Review & Submit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF101828),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Please review your application before submitting',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF99A1AF),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    _buildReviewRow('Loan Type', 'Personal Loan'),
                    _buildReviewRow('Loan Amount', '\$25,000'),
                    _buildReviewRow('Loan Term', '36 months'),
                    _buildReviewRow('Est. Rate', '9.5% APR'),
                    _buildReviewRow('Est. Monthly Payment', '\$801'),
                    _buildReviewRow('Purpose', 'rsj'),
                    _buildReviewRow('Employment', 'Full-time Employee'),
                    _buildReviewRow('Annual Income', '\$45,235'),
                    _buildReviewRow('Monthly Expenses', '\$32'),
                    _buildReviewRow('DTI Ratio', '22%'),
                    
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFA41F13),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, color: Colors.white, size: 14),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Documents',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF344054),
                              ),
                            ),
                          ),
                          const Text(
                            '1/5 uploaded',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFA41F13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFFF2F4F7)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chevron_left, color: Color(0xFF344054)),
                          SizedBox(width: 8),
                          Text(
                            'Back',
                            style: TextStyle(
                              color: Color(0xFF344054),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      onTap: () {
                        Get.to(() => const ApplicationSubmitted());
                      },
                      text: 'Submit Application',
                      color: const Color(0xFFA41F13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF99A1AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF101828),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        final step = index + 1;
        // Step 6 is the last step, so everything is completed or active
        final isCompleted = step < 6;
        final isLast = index == 5;

        return Expanded(
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isCompleted ? const Color(0xFF00C950) : AppColors.activeColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted ? const Color(0xFF00C950) : AppColors.activeColor,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : Text(
                          '$step',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    color: isCompleted ? const Color(0xFF00C950) : Colors.grey.shade300,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

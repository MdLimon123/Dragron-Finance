import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:demo_project/app/core/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:demo_project/app/features/loan/view/loan_apply_step2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:demo_project/app/features/loan/controller/loan_controller.dart';

class LoanApplyStep1 extends StatefulWidget {
  const LoanApplyStep1({super.key});

  @override
  State<LoanApplyStep1> createState() => _LoanApplyStep1State();
}

class _LoanApplyStep1State extends State<LoanApplyStep1> {
  int currentStep = 2;
  final controller = Get.find<LoanController>();

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
                      'Loan Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF101828),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tell us about the loan amount and terms',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF99A1AF),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildLabel('Loan Amount'),
                    CustomTextField(
                      controller: controller.loanAmountController,
                      hintText: '£20,000 to £500,000',
                      filled: true,
                      filColor: const Color(0xFFF2F4F7),
                    ),
                    const SizedBox(height: 20),
                    _buildLabel('Loan Term'),
                    CustomTextField(
                      controller: controller.loanTermController,
                      hintText: '36 months',
                      filled: true,
                      filColor: const Color(0xFFF2F4F7),
                    ),
                    const SizedBox(height: 20),
                    _buildLabel('Notes'),
                    CustomTextField(
                      controller: controller.notesController,
                      hintText: 'Please share your notes...',
                      minLines: 4,
                      filled: true,
                      filColor: const Color(0xFFF2F4F7),
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
                    child: Obx(
                      () => CustomButton(
                        isLoading: controller.isSubmitting.value,
                        onTap: () {
                          controller.submitStep1();
                        },
                        text: 'Continue',
                        color: AppColors.activeColor,
                        icon: const Icon(Icons.chevron_right, color: Colors.white),
                      ),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF292F36),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        final step = index + 1;
        final isCompleted = step < currentStep;
        final isActive = step == currentStep;
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

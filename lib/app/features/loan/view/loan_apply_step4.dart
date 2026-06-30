import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:demo_project/app/features/loan/controller/loan_controller.dart';

class LoanApplyStep4 extends StatefulWidget {
  const LoanApplyStep4({super.key});

  @override
  State<LoanApplyStep4> createState() => _LoanApplyStep4State();
}

class _LoanApplyStep4State extends State<LoanApplyStep4> {
  int currentStep = 5;
  final controller = Get.put(LoanController());

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
              const Text(
                'Credit History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101828),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please answer all questions honestly. This information is used to assess your application and will be verified.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF99A1AF),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              
              _buildQuestionCard(
                index: 0,
                question: 'Have you had any CCJs in the last 6 years?',
                subtext: 'County Court Judgements registered against you in England, Wales or Northern Ireland.',
              ),
              _buildQuestionCard(
                index: 1,
                question: 'Have you had any defaults in the last 6 years?',
                subtext: 'A default is recorded when you miss payments on a credit account for an extended period.',
              ),
              _buildQuestionCard(
                index: 2,
                question: 'Are you currently in an active Debt Management Plan (DMP)?',
                subtext: 'A DMP is an informal agreement with creditors to repay debts at a reduced rate.',
              ),
              _buildQuestionCard(
                index: 3,
                question: 'Are you currently in an active Individual Voluntary Arrangement (IVA)?',
                subtext: 'An IVA is a formal insolvency agreement between you and your creditors, supervised by an insolvency practitioner.',
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
                    child: Obx(() => CustomButton(
                      onTap: () {
                        controller.submitStep4();
                      },
                      text: 'Continue',
                      isLoading: controller.isSubmitting.value,
                      color: AppColors.activeColor,
                      icon: const Icon(Icons.chevron_right, color: Colors.white),
                    )),
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

  Widget _buildQuestionCard({
    required int index,
    required String question,
    required String subtext,
  }) {
    return Obx(() {
      bool? answer;
      if (index == 0) answer = controller.hasCcj.value;
      if (index == 1) answer = controller.hasDefaults.value;
      if (index == 2) answer = controller.hasActiveDmp.value;
      if (index == 3) answer = controller.hasActiveIva.value;

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppShadow.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF101828),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtext,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF99A1AF),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildSelectionButton(
                    label: 'Yes',
                    isSelected: answer == true,
                    onTap: () {
                      if (index == 0) controller.hasCcj.value = true;
                      if (index == 1) controller.hasDefaults.value = true;
                      if (index == 2) controller.hasActiveDmp.value = true;
                      if (index == 3) controller.hasActiveIva.value = true;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSelectionButton(
                    label: 'No',
                    isSelected: answer == false,
                    onTap: () {
                      if (index == 0) controller.hasCcj.value = false;
                      if (index == 1) controller.hasDefaults.value = false;
                      if (index == 2) controller.hasActiveDmp.value = false;
                      if (index == 3) controller.hasActiveIva.value = false;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSelectionButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFA41F13) : const Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : const Color(0xFF667085),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.white : Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF344054),
              ),
            ),
          ],
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

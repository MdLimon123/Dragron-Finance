import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';

import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:demo_project/app/features/loan/view/load_apply_step1.dart';
import 'package:demo_project/app/features/loan/controller/loan_controller.dart';
import 'package:demo_project/app/features/loan/model/loan_type_model.dart';
import 'package:demo_project/app/core/config/environment.dart';
import 'package:flutter/material.dart';

class LoanApplyPage extends StatefulWidget {
  const LoanApplyPage({super.key});

  @override
  State<LoanApplyPage> createState() => _LoanApplyPageState();
}

class _LoanApplyPageState extends State<LoanApplyPage> {
  int currentStep = 1;
  final controller = Get.put(LoanController());

  final List<Color> _iconColors = [
    const Color(0xFF4A90E2),
    const Color(0xFF27AE60),
    const Color(0xFFF39C12),
    const Color(0xFF8E44AD),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
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
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: AppShadow.soft
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Loan Type',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF101828),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Select the type of loan you\'d like to apply for',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF99A1AF),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.loanTypes.isEmpty) {
                      return const Center(child: Text("No loan types available"));
                    }
                    
                    final selectedId = controller.selectedLoanType.value?.id;
                    
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: controller.loanTypes.length,
                      itemBuilder: (context, index) {
                        final type = controller.loanTypes[index];
                        final isSelected = selectedId == type.id;
                        return _buildLoanTypeCard(type, isSelected, index);
                      },
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Obx(() => CustomButton(
              onTap: () {
                controller.createLoanApplication();
              },
              text: 'Continue',
              isLoading: controller.isSubmitting.value,
              color: AppColors.activeColor,
              icon: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            )),
            const SizedBox(height: 20),
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
                    height: 1,
                    color: isCompleted ? const Color(0xFF00C950) : Colors.grey.shade300,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLoanTypeCard(LoanTypeModel type, bool isSelected, int index) {
    final iconColor = _iconColors[index % _iconColors.length];
    
    return GestureDetector(
      onTap: () {
        controller.selectLoanType(type);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.activeColor : Colors.transparent,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.activeColor.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.20),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Image.network(
                EnvironmentConfig.baseHost + type.iconImageUrl,
                color: iconColor,
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image_not_supported,
                  color: iconColor,
                  size: 24,
                ),
              ),
            ),
        SizedBox(height: 12,),
            Text(
              type.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF101828),
                fontFamily: 'Inter',
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

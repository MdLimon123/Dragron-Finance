import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';

import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:demo_project/app/features/loan/view/load_apply_step1.dart';
import 'package:flutter/material.dart';

class LoanApplyPage extends StatefulWidget {
  const LoanApplyPage({super.key});

  @override
  State<LoanApplyPage> createState() => _LoanApplyPageState();
}

class _LoanApplyPageState extends State<LoanApplyPage> {
  int currentStep = 1;
  String? selectedLoanType = 'Debt Consolidation';

  final List<Map<String, dynamic>> loanTypes = [
    {
      'title': 'Debt Consolidation',
      'icon': "assets/icon/sync.svg",
      'color': const Color(0xFF4A90E2).withOpacity(0.20),
      'iconColor': const Color(0xFF4A90E2),
    },
    {
      'title': 'Debt Consolidation & Home Improvements',
      'icon': "assets/icon/debt.svg",
      'color': const Color(0xFF27AE60).withOpacity(0.20),
      'iconColor': const Color(0xFF27AE60),
    },
    {
      'title': 'Home Improvements',
      'icon': "assets/icon/home.svg",
      'color': const Color(0xFFF39C12).withOpacity(0.20),
      'iconColor': const Color(0xFFF39C12),
    },
    {
      'title': 'Other',
      'icon': "assets/icon/other.svg",
      'color': const Color(0xFF8E44AD).withOpacity(0.20),
      'iconColor': const Color(0xFF8E44AD),
    },
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
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: loanTypes.length,
                    itemBuilder: (context, index) {
                      final type = loanTypes[index];
                      final isSelected = selectedLoanType == type['title'];
                      return _buildLoanTypeCard(type, isSelected);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            CustomButton(
              onTap: () {
                Get.to(() => LoanApplyStep1());
              },
              text: 'Continue',
              color: AppColors.activeColor,
              icon: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
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

  Widget _buildLoanTypeCard(Map<String, dynamic> type, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLoanType = type['title'];
        });
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
                color: type['color'],
                borderRadius: BorderRadius.circular(14),
              ),
              child: SvgPicture.asset(
                type['icon'],
                color: type['iconColor'],
                width: 24,
                height: 24,
              ),
            ),
        SizedBox(height: 12,),
            Text(
              type['title'],
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

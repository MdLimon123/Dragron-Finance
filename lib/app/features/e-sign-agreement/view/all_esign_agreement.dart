import 'package:demo_project/app/core/config/environment.dart';
import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/features/e-sign-agreement/controller/esign_controller.dart';
import 'package:demo_project/app/features/e-sign-agreement/view/e_sign_agreement_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllEsignAgreement extends StatelessWidget {
  const AllEsignAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EsignController());

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.myLoans.isEmpty) {
            return const Center(
              child: Text(
                "No agreements found.",
                style: TextStyle(color: Color(0xFF676767), fontSize: 16),
              ),
            );
          }

          return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'E-Sign Agreements',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F0F0F),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Review and sign your pending documents.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF676767),
                ),
              ),
              const SizedBox(height: 32),
              
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.myLoans.length,
                itemBuilder: (context, index) {
                  final loan = controller.myLoans[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const ESignAgreementPage(), arguments: loan);
                      },
                      child: _buildAgreementCard(
                        title: loan.loanType.isNotEmpty ? loan.loanType : 'Unknown',
                        refNumber: loan.applicationNumber.isNotEmpty ? loan.applicationNumber : 'N/A',
                        status: loan.status == 'approved' ? 'Awaiting Signature' : loan.status,
                        iconUrl: loan.iconImageUrl,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
        }),
      ),
    );
  }

  Widget _buildAgreementCard({
    required String title,
    required String refNumber,
    required String status,
    required String iconUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFBEAE8), // light red
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: iconUrl.isNotEmpty 
                      ? Image.network(
                          '${EnvironmentConfig.baseHost}$iconUrl',
                          width: 24,
                          height: 24,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.description, color: Color(0xFFA41F13)),
                        )
                      : const Icon(Icons.description, color: Color(0xFFA41F13)),
                ),
              ),
              const SizedBox(width: 16),
              
              // Title and Ref
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF101828),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ref: $refNumber',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6A7282),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Status Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9EA),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFFFD57B),
                  ),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFB57017),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
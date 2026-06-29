import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/features/myLoan/view/myloan_overview_page.dart';
import 'package:demo_project/app/core/config/environment.dart';
import 'package:demo_project/app/features/myLoan/controller/my_loan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLoanPage extends StatelessWidget {
  MyLoanPage({super.key});

  final controller = Get.put(MyLoanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Loans',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF101828),
                        ),
                      ),
                      Obx(() => Text(
                        '${controller.summary.value?.totalApplications ?? 0} applications total',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF99A1AF),
                        ),
                      )),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA41F13),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_circle_outline, size: 18, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF7A1710),
                      Color(0xFFA41F13),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSummaryItem('-', 'Loan Amount'),
                    _buildSummaryItem('${controller.summary.value?.activeLoans ?? 0}', 'Active Loans'),
                    _buildSummaryItem('${controller.summary.value?.inReview ?? 0}', 'In Review'),
                  ],
                )),
              ),
              const SizedBox(height: 24),

              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppShadow.soft,
                  border: Border.all(color: const Color(0xFFF2F4F7)),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Color(0xFF99A1AF)),
                    hintText: 'Search by type or number...',
                    hintStyle: TextStyle(color: Color(0xFF99A1AF)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Tabs
              SizedBox(
                height: 48,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() => Row(
                    children: controller.tabs.map((tab) => _buildTabItem(tab)).toList(),
                  )),
                ),
              ),
              const SizedBox(height: 24),

              // Loan Cards
              Obx(() {
                if (controller.isLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(child: CircularProgressIndicator(color: Color(0xFFA41F13))),
                  );
                }
                if (controller.loans.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        "No loans found",
                        style: TextStyle(color: Color(0xFF6A7282), fontSize: 16),
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    ...controller.loans.map((loan) {
                      Color statusColor;
                      Color statusTextColor;
                      String statusText;

                      if (loan.status == 'active') {
                        statusText = 'Active';
                        statusColor = const Color(0xFFDCFCE7);
                        statusTextColor = const Color(0xFF008236);
                      } else if (loan.status == 'under_review') {
                        statusText = 'Under Review';
                        statusColor = const Color(0xFFFEF3C6);
                        statusTextColor = const Color(0xFFBB4D00);
                      } else if (loan.status == 'completed') {
                        statusText = 'Completed';
                        statusColor = const Color(0xFFE0F2FE);
                        statusTextColor = const Color(0xFF0284C7);
                      } else {
                        statusText = loan.status;
                        statusColor = Colors.grey.shade200;
                        statusTextColor = Colors.grey.shade800;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildLoanCard(
                          title: loan.loanType,
                          id: loan.applicationNumber,
                          amount: '\$${loan.loanAmount}',
                          term: loan.loanTerm,
                          status: statusText,
                          statusColor: statusColor,
                          statusTextColor: statusTextColor,
                          iconImageUrl: loan.iconImageUrl,
                        ),
                      );
                    }).toList(),
                    if (controller.isFetchingMore.value)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: CircularProgressIndicator(color: Color(0xFFA41F13)),
                        ),
                      ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(String title) {
    bool isSelected = controller.selectedTab.value == title;
    return GestureDetector(
      onTap: () => controller.changeTab(title),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFA41F13) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? const Color(0xFFA41F13) : const Color(0xFFF2F4F7)),
          boxShadow: AppShadow.soft,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF6A7282),
          ),
        ),
      ),
    );
  }

  Widget _buildLoanCard({
    required String title,
    required String id,
    required String amount,
    required String term,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    String? iconImageUrl,
    IconData fallbackIcon = Icons.home_outlined,
  }) {
    return GestureDetector(
      onTap: () => Get.to(() => const MyLoanOverviewPage()),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppShadow.soft,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFBEAE8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: (iconImageUrl != null && iconImageUrl.isNotEmpty)
                  ? Image.network(
                      EnvironmentConfig.baseHost + iconImageUrl,
                      width: 24,
                      height: 24,
                      color: const Color(0xFFA41F13),
                      errorBuilder: (context, error, stackTrace) => Icon(fallbackIcon, color: const Color(0xFFA41F13), size: 24),
                    )
                  : Icon(fallbackIcon, color: const Color(0xFFA41F13), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101828),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: statusTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    id,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF99A1AF),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF101828),
                    ),
                  ),
                  Text(
                    term,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF99A1AF),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Color(0xFFD0D5DD)),
          ],
        ),
      ),
    );
  }
}

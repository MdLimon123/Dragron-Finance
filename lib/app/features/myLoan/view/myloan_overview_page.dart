import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

class MyLoanOverviewPage extends StatefulWidget {
  const MyLoanOverviewPage({super.key});

  @override
  State<MyLoanOverviewPage> createState() => _MyLoanOverviewPageState();
}

class _MyLoanOverviewPageState extends State<MyLoanOverviewPage> {
  int activeTab = 0; // 0: Overview, 1: Documents, 2: Timeline

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: InkWell(
                onTap: () => Get.back(),
                child: const Row(
                  children: [
                    Icon(Icons.chevron_left, size: 20, color: Color(0xFF667085)),
                    SizedBox(width: 4),
                    Text(
                      'Back to My Loans',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF667085),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  children: [
                    _buildHeaderCard(),
                    const SizedBox(height: 24),
                    _buildTabSwitcher(),
                    const SizedBox(height: 24),
                    _buildActiveTabContent(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7A1710), Color(0xFFA41F13)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.home_outlined, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Homeowner Loan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(38),
                          ),
                          child: const Text(
                            'Approved',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF008236),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'LS-2024-001',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderStat('Loan Amount', '\$350,000'),
              _buildHeaderStat('Monthly Payment', '\$2,270'),
              _buildHeaderStat('Term', '2 Years'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Application Progress',
                style: TextStyle(fontSize: 12, 
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.6)),
              ),
              const Text(
                '100%',
                style: TextStyle(fontSize: 12,
                 fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 1.0,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, 
          fontWeight: FontWeight.w400,
          color: Colors.white.withOpacity(0.6)),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6),
        width: 1
        ),
        boxShadow: AppShadow.soft,
      ),
      child: Row(
        children: [
          _buildTabBtn(0, 'Overview'),
          _buildTabBtn(1, 'Documents'),
          _buildTabBtn(2, 'Timeline'),
        ],
      ),
    );
  }

  Widget _buildTabBtn(int index, String title) {
    bool isSelected = activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => activeTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFA41F13) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF6A7282),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTabContent() {
    switch (activeTab) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildDocumentsTab();
      case 2:
        return _buildTimelineTab();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      children: [
        _buildInfoSection('Loan Details', [
          ['Loan Type', 'Home Loan'],
          ['Amount', '\$350,000'],
          ['Term', '360 months (30 years)'],
          ['Interest Rate', '6.75% APR'],
          ['Monthly Payment', '\$2,270'],
          ['Purpose', 'Purchase primary\nresidence in San Francisco'],
          ['Applied', 'Jan 20, 2024'],
          ['Last Updated', 'Feb 15, 2024'],
        ]),
        const SizedBox(height: 20),
        _buildInfoSection('Financial Summary', [
          ['Annual Income', '\$85,000'],
          ['Monthly Expenses', '\$3,200'],
          ['Employment', 'Full Time'],
          ['DTI Ratio', '32%'],
        ]),
        const SizedBox(height: 20),
        _buildRiskAssessmentCard(),
        const SizedBox(height: 20),
        _buildAdminNotes(),
      ],
    );
  }

  Widget _buildInfoSection(String title, List<List<String>> items) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6),
        width: 1
        ),
        boxShadow: AppShadow.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14,
             fontWeight: FontWeight.w600, color: Color(0xFF101828)),
          ),
          const SizedBox(height: 20),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        item[0],
                        style: const TextStyle(fontSize: 14,
                         color: Color(0xFF99A1AF),
                          fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        item[1],
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 14, 
                        fontWeight: FontWeight.w600,
                         color: Color(0xFF101828)),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildRiskAssessmentCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4C1D95), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
     
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icon/risk_assessment.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'AI Risk Assessment',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: CircularProgressIndicator(
                      value: 0.78,
                      strokeWidth: 6,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  const Text(
                    '78',
                    style: TextStyle(fontSize: 14, 
                    fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Risk Score',
                    style: TextStyle(fontSize: 12,
                    fontWeight: FontWeight.w400,
                     color: Color(0xFFE9D4FF)),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(37),
                    ),
                    child: const Text(
                      'Approve Recommended',
                      style: TextStyle(fontSize: 12,
                       fontWeight: FontWeight.w700,
                        color: Color(0xFF065F46)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Sarah Johnson presents a low-risk profile for this \$350,000 home loan. Strong credit history, stable income, and reasonable DTI ratio support an approval recommendation. Loan-to-value ratio is typical for the market segment.',
            style: TextStyle(fontSize: 13,
             color: Color(0xFFF3E8FF), height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminNotes() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFEF3C6),
        width: 1),
 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            children: [

                SvgPicture.asset('assets/icon/admin_note.svg'),

              SizedBox(width: 8),
              Text(
                'Admin Notes',
                style: TextStyle(fontSize: 14, 
                fontWeight: FontWeight.w600,
                 color: Color(0xFFBB4D00)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Strong credit history, stable employment.\nApproved with standard terms.',
            style: TextStyle(fontSize: 14, 
            fontWeight: FontWeight.w400,

            color: Color(0xFFBB4D00), 
            height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: AppShadow.soft,
          ),
          child: Column(
            children: [
              _buildDocItem('Pay Stub - January 2024.pdf', '245 KB • Jan 28, 2024'),
              _buildDocItem('Bank Statement - Nov 2023.pdf', '1.2 MB • Jan 28, 2024'),
              _buildDocItem('Bank Statement - Dec 2023.pdf', '1.1 MB • Jan 28, 2024'),
              _buildDocItem('Tax Return 2022.pdf', '892 KB • Jan 28, 2024'),
              _buildDocItem('Property Appraisal Report.pdf', '3.4 MB • Feb 2, 2024', isLast: true),
            ],
          ),
        ),
        const SizedBox(height: 32),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            side:  BorderSide(color: Color(0xFFA41F134D)
            .withValues(alpha: 0.3)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: const Color(0xFFFBEAE8).withOpacity(0.3),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.file_upload_outlined,
               color: Color(0xFFA41F13), size: 20),
              SizedBox(width: 8),
              Text(
                'Upload New Document',
                style: TextStyle(color: Color(0xFFA41F13),
                fontSize: 14,
                 fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDocItem(String name, String details, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBEAE8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.description_outlined, color: Color(0xFFA41F13), size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF344054)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      details,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF99A1AF)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(37),
                ),
                child: const Text(
                  'Approved',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF008236)),
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1, color: Color(0xFFF2F4F7), indent: 16, endIndent: 16),
      ],
    );
  }

  Widget _buildTimelineTab() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadow.soft,
      ),
      child: Column(
        children: [
          _buildTimelineItem(
            'Application submitted by customer',
            'Sarah Johnson • Jan 20, 2024, 04:00 PM',
            'assets/icon/docs.svg',
            color: const Color(0xFFA41F13),
          ),
          _buildTimelineItem(
            'Status changed from submitted to under_review',
            'Alex Rivera • Jan 22, 2024, 03:00 PM',
            'assets/icon/tree.svg',
            color: const Color(0xFFE17100),
          ),
          _buildTimelineItem(
            'AI risk assessment completed. Score: 78/100, Recommendation: Approve',
            'AI Engine • Jan 23, 2024, 08:00 PM',
            'assets/icon/risk_assessment.svg',
            color: const Color(0xFF9810FA),
          ),
          _buildTimelineItem(
            'Additional documents requested: Bank statements (3 months), Tax returns (2 years)',
            'Alex Rivera • Jan 25, 2024, 05:00 PM',
            'assets/icon/upload_fill.svg',
            color: const Color(0xFFF54900),
          ),
          _buildTimelineItem(
            'Customer uploaded 4 documents',
            'Sarah Johnson • Jan 28, 2024, 10:00 PM',
             Icons.check_circle_outline,
          
            color: Color(0xFF00A63E),
          ),
          _buildTimelineItem(
        
            'Admin note: Strong credit history, stable employment for 4+ years',
            'Alex Rivera • Feb 10, 2024, 04:00 PM',
            'assets/icon/docs.svg',
          ),
          _buildTimelineItem(
            'Application approved with standard 30-year fixed rate of 6.75%',
            'Alex Rivera • Feb 15, 2024, 08:30 PM',
            Icons.check_circle_outline,
            isLast: true,
            color: Color(0xFF00A63E),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    String title,
    String details,
    dynamic icon, {
    Color color = const Color(0xFF99A1AF),
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFF3F4F6),
                shape: BoxShape.circle,
              ),
              child: icon is String
                  ? SvgPicture.asset(
                      icon,
                      color: color,
                      height: 16,
                      width: 16,
                    )
                  : Icon(
                      icon as IconData,
                      color: color,
                      size: 16,
                    ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: const Color(0xFFF2F4F7),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const 
                TextStyle(fontSize: 14, 
                fontWeight: FontWeight.w500,
                 color: Color(0xFF101828), height: 1.4),
              ),
              const SizedBox(height: 4),
              Text(
                details,
                style: TextStyle(fontSize: 12, 
                color: Color(0xFF99A1AF),
                fontWeight: FontWeight.w400,
              ),),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
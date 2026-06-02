import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/features/e-sign-agreement/view/document_overview_page.dart';
import 'package:demo_project/app/features/e-sign-agreement/view/signature_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ESignAgreementPage extends StatefulWidget {
  const ESignAgreementPage({super.key});

  @override
  State<ESignAgreementPage> createState() => _ESignAgreementPageState();
}

class _ESignAgreementPageState extends State<ESignAgreementPage> {
  final List<bool> _expanded = [false, false, false];

  final List<Map<String, String>> _sections = [
    {
      'title': '1. Loan Amount',
      'body':
          'This is the loan amount — the total amount of money you borrow from a lender, before interest and fees are added.',
    },
    {
      'title': '2. Interest Rate & Repayments',
      'body':
          'The interest rate is the percentage a lender charges for borrowing money, determining how much extra you pay on top of the loan, while repayments are the regular payments you make over time to pay back both the original amount borrowed and the added interest.',
    },
    {
      'title': '3. Security Address',
      'body':
          'The security address is the property linked to a loan that acts as a form of assurance for the lender, meaning it\'s simply the place connected to the loan.',
    },
  ];

  final List<List<Offset?>> _strokes = [];
  List<Offset?> _currentStroke = [];
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: CustomAppBar(),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHomeLoanCard(),

                    SizedBox(height: 20),
                    _documentPreview(),
                    SizedBox(height: 20),

                    _signature(),
                    SizedBox(height: 20),

                    _conditionContainer(),
                    SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/icon/lock.svg'),

                        SizedBox(width: 8),

                        Text(
                          "Your signature is timestamped and stored securely.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF9A9490),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    _buildContinueButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _conditionContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE0DBD8), width: 0.5),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _agreed = !_agreed),
            child: Container(
              width: 22,
              height: 22,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: _agreed ? const Color(0xFFA41F13) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _agreed
                      ? const Color(0xFFA41F13)
                      : const Color(0xFFD5CFC9),
                  width: 1.5,
                ),
              ),
              child: _agreed
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'I have read and understood the terms of the homeowner loan agreement and I am happy to proceed.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6A6460),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signature() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE0DBD8), width: 1.08),
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
        children: [
          const Text(
            'YOUR SIGNATURE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: Color(0xFF6A6460),
            ),
          ),
          const SizedBox(height: 16),

          // Tab Row
          _buildTab('Draw', Icons.edit_outlined),

          const SizedBox(height: 17),

          // Signature Canvas
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFAF5F1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFAF5F1), width: 0.5),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  child: GestureDetector(
                    onPanStart: (d) {
                      setState(() {
                        _currentStroke = [d.localPosition];
                        _strokes.add(_currentStroke);
                      });
                    },
                    onPanUpdate: (d) {
                      setState(() => _currentStroke.add(d.localPosition));
                    },
                    onPanEnd: (_) {
                      setState(() => _currentStroke.add(null));
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: CustomPaint(
                        painter: SignaturePainter(_strokes),
                        child: Container(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFD0CAC6),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Sign above the line',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC4BFBC),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Button Row
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => setState(() => _strokes.clear()),
                icon: const Icon(Icons.refresh, size: 16),
                label: Text(
                  'Clear',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6A6460),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF6A6460),
                  side: const BorderSide(color: Color(0xFFD5CFC9), width: 0.5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFA41F13), Color(0xFF7A1710)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_strokes.isEmpty) return;
                      // handle signature
                    },
                    icon: const Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Use This Signature',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _documentPreview() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE0DBD8), width: 1.11),

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
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: const [
                Icon(
                  Icons.remove_red_eye_outlined,
                  size: 18,
                  color: Color(0xFF6A6460),
                ),
                SizedBox(width: 8),
                Text(
                  'Document Preview',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF292F36),
                  ),
                ),
              ],
            ),
          ),

          // Borrower / Lender Row
          IntrinsicHeight(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF5F1),

                border: Border.all(color: const Color(0xFFF0ECE9), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(child: _buildParty('BORROWER', 'Sarah Johnson')),

                  Expanded(
                    child: _buildParty('LENDER', 'LoanSphere Financial Ltd.'),
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 0.5, thickness: 0.5, color: Color(0xFFE5E0DC)),

          // Accordion Sections
          ...List.generate(_sections.length, (i) {
            final isLast = i == _sections.length - 1;
            return Column(
              children: [
                _buildAccordionItem(i),
                if (!isLast)
                  const Divider(
                    height: 0.5,
                    thickness: 0.5,
                    color: Color(0xFFE5E0DC),
                  ),
              ],
            );
          }),
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
              'Sign Agreement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF292F36),
              ),
            ),

            Text(
              'Review and e-sign your loan document',
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



  Widget _buildHomeLoanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE0DBD8), width: 1.08),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Box
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFBEAE8), Color(0xFFFAF5F1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEADAD6), width: 1),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icon/docs.svg',
                width: 24,
                height: 24,
                color: const Color(0xFFA41F13),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Title, Ref & Stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Home Loan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF292F36),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Ref: LS-2024-001',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6A6460),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: const Color(0xFFFEE685),
                          width: 1.2,
                        ),
                      ),
                      child: const Text(
                        'Awaiting Signature',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFBB4D00),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(child: _buildStat('AMOUNT', '\$350,000')),
                    Expanded(child: _buildStat('TERM', '30 years')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildStat('RATE', '6.75%')),
                    Expanded(child: _buildStat('MONTHLY', '\$2,270')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9A9490),
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF292F36),
          ),
        ),
      ],
    );
  }

  Widget _buildParty(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              letterSpacing: 0.8,
              color: Color(0xFF9A9490),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF292F36),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccordionItem(int index) {
    final section = _sections[index];
    final isOpen = _expanded[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded[index] = !isOpen),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    section['title']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF292F36),
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: Color(0xFF9E9890),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 14),
            child: Text(
              section['body']!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6A6460),
                fontWeight: FontWeight.w400,
                height: 1.6,
              ),
            ),
          ),
          crossFadeState: isOpen
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 220),
        ),
      ],
    );
  }

  Widget _buildTab(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      width: 90,
      height: 37,
      decoration: BoxDecoration(
        color: Color(0xFFFBEAE8),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Color(0xFFA41F13), width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Color(0xFFA41F13)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFFA41F13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
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
            Get.to(() => const DocumentOverviewPage());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icon/agree.svg'),
              SizedBox(width: 6),
              Text(
                ' Agree & Sign Document',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

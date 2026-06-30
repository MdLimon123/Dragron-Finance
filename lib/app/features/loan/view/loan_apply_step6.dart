import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:demo_project/app/features/loan/controller/loan_controller.dart';
import 'package:demo_project/app/features/loan/view/upload_document_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanApplyStep6 extends StatefulWidget {
  const LoanApplyStep6({super.key});

  @override
  State<LoanApplyStep6> createState() => _LoanApplyStep6State();
}

class _LoanApplyStep6State extends State<LoanApplyStep6> {
  final controller = Get.put(LoanController());
  final Map<String, bool> _expandedState = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchStep6Data();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColors.activeColor));
          }

          final data = controller.step6Data;
          if (data.isEmpty) {
            return const Center(child: Text("No document data found."));
          }

          final summary = data['summary'] ?? {};
          final notice = data['notice'] ?? {};
          final application = data['application'] ?? {};
          final loanType = application['loanType']?['name'] ?? 'Loan';
          final categories = data['categories'] as List<dynamic>? ?? [];

          // Initialize expansion states if not set
          for (var cat in categories) {
            final key = cat['categoryKey']?.toString() ?? '';
            if (key.isNotEmpty && !_expandedState.containsKey(key)) {
              _expandedState[key] = true;
            }
          }

          final progressPercent = (summary['progressPercent'] as num?)?.toDouble() ?? 0.0;

          return SingleChildScrollView(
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
                
                // Required Documents Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Required Documents',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF101828),
                            ),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF667085),
                                fontFamily: 'Inter',
                              ),
                              children: [
                                const TextSpan(text: 'For your '),
                                TextSpan(
                                  text: '$loanType\n',
                                  style: const TextStyle(color: Color(0xFFA41F13), fontWeight: FontWeight.w600),
                                ),
                                const TextSpan(text: 'application'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            (summary['uploadedText']?.toString() ?? '0/0').replaceFirst(' ', '\n'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFA41F13),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          summary['statusText']?.toString() ?? '0 required remaining',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF667085),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Progress Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Upload progress',
                      style: TextStyle(fontSize: 12, color: Color(0xFF667085)),
                    ),
                    Text(
                      '${progressPercent.toInt()}%',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF101828)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progressPercent / 100.0,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFFA41F13),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Segmented progress (Mocked segments as per design)
                Row(
                  children: [
                    Expanded(child: _buildProgressSegment(progressPercent > 0)),
                    const SizedBox(width: 4),
                    Expanded(child: _buildProgressSegment(progressPercent > 20)),
                    const SizedBox(width: 4),
                    Expanded(child: _buildProgressSegment(progressPercent > 40)),
                    const SizedBox(width: 4),
                    Expanded(child: _buildProgressSegment(progressPercent > 60)),
                    const SizedBox(width: 4),
                    Expanded(child: _buildProgressSegment(progressPercent > 80)),
                  ],
                ),
                
                const SizedBox(height: 24),
                // Info Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4F7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, size: 20, color: Color(0xFF667085)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF667085),
                              height: 1.5,
                              fontFamily: 'Inter',
                            ),
                            children: _parseNoticeText(
                              notice['text']?.toString() ?? '',
                              notice['mandatorySymbol']?.toString() ?? '*',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Categories
                ...categories.map((category) {
                  final key = category['categoryKey']?.toString() ?? '';
                  final isIdentity = key.contains('identity');
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildAccordionCard(
                      title: category['categoryTitle']?.toString() ?? '',
                      subtitle: category['uploadedText']?.toString() ?? '',
                      isExpanded: _expandedState[key] ?? true,
                      iconData: isIdentity ? Icons.badge_outlined : Icons.account_balance_wallet_outlined,
                      iconColor: isIdentity ? const Color(0xFFA41F13) : const Color(0xFF344054),
                      headerColor: isIdentity ? const Color(0xFFFEF2F2) : const Color(0xFFF3F4F6),
                      borderColor: isIdentity ? const Color(0xFFFECACA) : const Color(0xFFE5E7EB),
                      onToggle: () {
                        setState(() {
                          _expandedState[key] = !(_expandedState[key] ?? true);
                        });
                      },
                      children: _buildDocumentItems(category['documents'] as List<dynamic>? ?? []),
                    ),
                  );
                }),
                
                const SizedBox(height: 24),
                // Bottom Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFFE5E7EB)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chevron_left, color: Color(0xFF344054)),
                            SizedBox(width: 4),
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
                        onTap: controller.isSubmitting.value ? () {} : () {
                          controller.completeDocument();
                        },
                        text: controller.isSubmitting.value ? 'Loading...' : 'Continue',
                        color: const Color(0xFFA41F13),
                        icon: controller.isSubmitting.value ? null : const Icon(Icons.chevron_right, color: Colors.white),
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        }),
      ),
    );
  }

  List<TextSpan> _parseNoticeText(String text, String symbol) {
    if (text.isEmpty) return [];
    if (!text.contains(symbol)) {
      return [TextSpan(text: text)];
    }
    
    List<TextSpan> spans = [];
    final parts = text.split(symbol);
    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i]));
      if (i < parts.length - 1) {
        spans.add(TextSpan(text: symbol, style: const TextStyle(color: Color(0xFFA41F13))));
      }
    }
    return spans;
  }

  List<Widget> _buildDocumentItems(List<dynamic> documents) {
    List<Widget> items = [];
    for (int i = 0; i < documents.length; i++) {
      final doc = documents[i];
      final status = doc['status']?.toString() ?? 'missing';
      
      Widget trailing;
      IconData iconData;
      Color iconBgColor;
      Color iconColor;
      Color titleColor;
      Color bgColor = Colors.white;

      if (status == 'uploaded') {
        iconData = Icons.check_circle_outline;
        iconBgColor = const Color(0xFFDCFCE7);
        iconColor = const Color(0xFF16A34A);
        titleColor = const Color(0xFF16A34A);
        bgColor = const Color(0xFFF0FDF4);
        trailing = Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFFDCFCE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 12, color: Color(0xFF16A34A)),
            ),
            const SizedBox(height: 4),
            const Text('Remove', style: TextStyle(fontSize: 12, color: Color(0xFF667085), decoration: TextDecoration.underline)),
          ],
        );
      } else if (status == 'uploading') {
        iconData = Icons.receipt_long_outlined;
        iconBgColor = const Color(0xFFFEF3C7);
        iconColor = const Color(0xFFD97706);
        titleColor = const Color(0xFF344054);
        trailing = Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            'Uploading...',
            style: TextStyle(
              color: Color(0xFFD97706),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      } else {
        // Missing
        iconData = Icons.description_outlined;
        iconBgColor = const Color(0xFFF3F4F6);
        iconColor = const Color(0xFF667085);
        titleColor = const Color(0xFF344054);
        trailing = Stack(
          clipBehavior: Clip.none,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Get.to(() => UploadDocumentPage(
                  documentType: doc['documentType']?.toString() ?? '',
                  documentTitle: doc['title']?.toString() ?? 'Document',
                ));
                
                if (result == true) {
                  controller.fetchStep6Data();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA41F13),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: const Size(0, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: const Icon(Icons.upload_file, size: 16),
              label: const Text('Upload', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ),
            if (doc['isRequired'] == true)
              Positioned(
                top: -8,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEF2F2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.error_outline, size: 14, color: Color(0xFFA41F13)),
                ),
              ),
          ],
        );
      }

      items.add(
        _buildDocumentItem(
          iconData: iconData,
          iconBgColor: iconBgColor,
          iconColor: iconColor,
          title: doc['title']?.toString() ?? '',
          titleColor: titleColor,
          subtitle: doc['description']?.toString() ?? '',
          trailing: trailing,
          bgColor: bgColor,
        ),
      );

      if (i < documents.length - 1) {
        items.add(const Divider(height: 1, color: Color(0xFFF3F4F6)));
      }
    }
    return items;
  }

  Widget _buildProgressSegment(bool isActive) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF00C950) : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildAccordionCard({
    required String title,
    required String subtitle,
    required bool isExpanded,
    required IconData iconData,
    required Color iconColor,
    required Color headerColor,
    required Color borderColor,
    required VoidCallback onToggle,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: isExpanded 
                  ? const BorderRadius.vertical(top: Radius.circular(15)) 
                  : BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(iconData, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: iconColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: iconColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: iconColor,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Column(
              children: children,
            ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem({
    required IconData iconData,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required Color titleColor,
    required String subtitle,
    required Widget trailing,
    Color bgColor = Colors.white,
  }) {
    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF667085),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          trailing,
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        final step = index + 1;
        // Steps 1-5 are complete (green check)
        // Step 6 is active/red
        final isCompleted = step <= 5;
        final isLast = index == 5;

        return Expanded(
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isCompleted ? const Color(0xFF00C950) : const Color(0xFFA41F13),
                  shape: BoxShape.circle,
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
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    color: isCompleted ? const Color(0xFF00C950) : const Color(0xFFE5E7EB),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

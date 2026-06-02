import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:flutter/material.dart';

class DocumentOverviewPage extends StatelessWidget {
  const DocumentOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 163),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFE0DBD8).withValues(alpha: 0.60),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withValues(alpha: 0.10),
                blurRadius: 10,
                spreadRadius: -6,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: const Color(0xFF000000).withValues(alpha: 0.10),
                blurRadius: 25,
                spreadRadius: -5,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFECFDF5), Color(0xFFD1FAE5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFECFDF5),

                      spreadRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Color(0xFF00BC7D),
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                'Document Signed!',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF292F36),
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              const Text(
                'Your homeowner loan agreement has been signed and we will be in contact shortly with an update.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6A6460),
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),

              // Ref & Date
              const Text(
                'Ref: LS-2024-001 · April 19, 2026',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9A9490),
                ),
              ),
              const SizedBox(height: 24),

              // Download Button
              _buildOutlineButton(
                icon: Icons.download_outlined,
                label: 'Download Signed PDF',
                onTap: () {},
              ),
              const SizedBox(height: 10),

              // View Button
              _buildOutlineButton(
                icon: Icons.remove_red_eye_outlined,
                label: 'View Signed Document',
                onTap: () {},
              ),
              const SizedBox(height: 16),

              // Back to Dashboard
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFA41F13), Color(0xFF7A1710)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Back to Dashboard',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16, color: const Color(0xFF3D3530)),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xFFFAF5F1),
          foregroundColor: const Color(0xFF3D3530),
          side: const BorderSide(color: Color(0xFFD5CFC9), width: 0.5),
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFF292F36),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';

import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UploadDocumentPage extends StatelessWidget {
  const UploadDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(height: 94),
              const Center(
                child: Text(
                  'Upload Documents',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F0F0F),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Dropzone Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                 border: Border.all(color: Color(0xFFFFFFFF)
                 .withOpacity(0.30)),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/icon/claud.svg'),
                    const SizedBox(height: 20),
                    RichText(
                      text: const TextSpan(
                        text: 'Drag & drop files or ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF333333),
                        ),
                        children: [
                          TextSpan(
                            text: 'Browse',
                            style: TextStyle(
                              color: Color(0xFFA41F13),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Supported formates: JPEG, PNG, GIF, MP4, PDF, PSD, AI, Word, PPT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF676767),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Uploading Section
              const Text(
                'Uploading - 3/3 files',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF676767),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFE3E3E3), width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'your-file-here.PDF',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF0F0F0F),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Color(0xFFE6E6E6),
                            shape: BoxShape.circle,
                          ),
                          child:Icon(Icons.close, color: Colors.white, size: 15),
                        ),
                      ],
                    ),
                  
                 
              ),
                Container(
                      height: 2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFA41F13),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 24),

              // Uploaded Section
              const Text(
                'Uploaded',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF676767),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              _buildUploadedFile('document-name.PDF'),
              const SizedBox(height: 12),
              _buildUploadedFile('image-name-goes-here.png'),

              const SizedBox(height: 40),
              CustomButton(
                onTap: () {},
                text: 'UPLOAD FILES',
                color: const Color(0xFFA41F13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadedFile(String fileName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF11AF22), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fileName,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF0F0F0F),
            ),
          ),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: Color(0xFFFFF3F3),
              shape: BoxShape.circle,
            ),
            child:Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset('assets/icon/delete.svg'),
            ),
          ),
        ],
      ),
    );
  }
}

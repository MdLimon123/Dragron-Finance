import 'dart:io';

import 'package:flutter/material.dart';
import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:demo_project/app/features/loan/controller/loan_controller.dart';

class UploadDocumentPage extends StatefulWidget {
  final String documentType;
  final String documentTitle;

  const UploadDocumentPage({
    super.key,
    required this.documentType,
    required this.documentTitle,
  });

  @override
  State<UploadDocumentPage> createState() => _UploadDocumentPageState();
}

class _UploadDocumentPageState extends State<UploadDocumentPage> {
  final controller = Get.find<LoanController>();
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
  }

  bool _isPicking = false;

  Future<void> _pickFile() async {
    if (_isPicking) return;
    
    setState(() {
      _isPicking = true;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'pdf', 'psd', 'ai', 'doc', 'docx', 'ppt', 'pptx'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick file", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      if (mounted) {
        setState(() {
          _isPicking = false;
        });
      }
    }
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
    });
  }

  Future<void> _saveAndGoBack() async {
    if (_selectedFile != null) {
      bool success = await controller.uploadDocument(widget.documentType, _selectedFile!);
      if (success) {
        Get.back(result: true); // Signal that an upload happened
      }
    } else {
      Get.snackbar("Error", "Please pick a file first", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

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
              const SizedBox(height: 94),
              Center(
                child: Text(
                  'Upload ${widget.documentTitle}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F0F0F),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Dropzone Card
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFFFFFF).withOpacity(0.30)),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icon/claud.svg'),
                      const SizedBox(height: 20),
                      RichText(
                        text: const TextSpan(
                          text: 'Tap to ',
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
                        'Supported formats: JPEG, PNG, GIF, MP4, PDF, PSD, AI, Word, PPT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF676767),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Uploaded Section
              if (_selectedFile != null) ...[
                const Text(
                  'Selected File',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF676767),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                _buildUploadedFile(_selectedFile!.path.split('/').last),
              ],

              const SizedBox(height: 40),
              Obx(() => CustomButton(
                onTap: controller.isSubmitting.value ? () {} : _saveAndGoBack,
                text: controller.isSubmitting.value ? 'UPLOADING...' : 'CONFIRM',
                color: const Color(0xFFA41F13),
              )),
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
          Expanded(
            child: Text(
              fileName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF0F0F0F),
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: _removeFile,
            child: Container(
              height: 24,
              width: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF3F3),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset('assets/icon/delete.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:demo_project/app/features/KYC-Verify/view/under_review_page.dart';
import 'package:demo_project/app/features/appMain/view/app_main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/core/network/api_exception.dart';
import 'package:demo_project/app/features/KYC-Verify/view/check_selfie_page.dart';
import 'package:demo_project/app/features/KYC-Verify/model/kyc_status_model.dart';


class KycVerifyController extends GetxController {
  final BaseApiService _apiService = BaseApiService();

  RxString selectedDocumentType = 'Driving License'.obs;
  Rx<File?> frontImage = Rx<File?>(null);
  Rx<File?> backImage = Rx<File?>(null);
  Rx<File?> selfieImage = Rx<File?>(null);
  RxBool isLoading = false.obs;

  Rx<KycResponse?> kycResponse = Rx<KycResponse?>(null);
  RxBool isLoadingStatus = false.obs;
  RxBool isSubmittingKyc = false.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    getKycStatus();
  }

  void selectDocumentType(String type) {
    selectedDocumentType.value = type;
  }

  Future<void> pickSelfieFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selfieImage.value = File(image.path);
    }
  }

  Future<void> pickSelfieFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selfieImage.value = File(image.path);
    }
  }

  Future<void> pickFrontImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      frontImage.value = File(image.path);
    }
  }

  Future<void> pickBackImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      backImage.value = File(image.path);
    }
  }

  Future<void> uploadKycDocs() async {
    if (frontImage.value == null || backImage.value == null) {
      Get.snackbar('Error', 'Please upload both front and back photos');
      return;
    }

    isLoading.value = true;
    try {
      final docType = selectedDocumentType.value == 'Driving License' ? 'driving_license' : 'passport';

      await _apiService.postMultipart(
        ApiEndpoints.uploadKycDocs,
        fields: {
          'document_type': docType,
        },
        files: {
          'front_file': frontImage.value!,
          'back_file': backImage.value!,
        },
      );

    Get.snackbar(
     "Success",
    "KYC ID documents uploaded successfully",
    backgroundColor: Colors.green,
    colorText: Colors.white,
    );

      Get.to(() => const CheckSelfiePage());
    } catch (e) {
      print('====> Error uploading KYC Docs: $e');
      if (e is ApiException) {
        print('====> ApiException details: ${e.message}, ');
      }
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadSelfie() async {
    if (selfieImage.value == null) {
      Get.snackbar('Error', 'Please take or upload a selfie');
      return;
    }

    isLoading.value = true;
    try {
      await _apiService.postMultipart(
        ApiEndpoints.uploadSelfie,
        files: {
          'selfie_file': selfieImage.value!,
        },
      );

      Get.snackbar(
        "Success",
        "Selfie uploaded successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.to(() => const UnderReviewPage());
    } catch (e) {
      print('====> Error uploading Selfie: $e');
      if (e is ApiException) {
        print('====> ApiException details: ${e.message},');
      }
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getKycStatus() async {
    isLoadingStatus.value = true;
    try {
      final response = await _apiService.get(ApiEndpoints.getKycStatus);
      if (response != null) {
        kycResponse.value = KycResponse.fromJson(response);
      }
    } catch (e) {
      print('====> Error getting KYC status: $e');
    } finally {
      isLoadingStatus.value = false;
    }
  }

  Future<void> submitKyc() async {
    isSubmittingKyc.value = true;
    try {
      await _apiService.post(ApiEndpoints.submitKyc, body: {});
      Get.snackbar(
        "Success",
        "KYC submitted successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAll(() =>  AppMainPage());
    } catch (e) {
      print('====> Error submitting KYC: $e');
      if (e is ApiException) {
        print('====> ApiException details: ${e.message},');
      }
      Get.snackbar('Error', e.toString());
    } finally {
      isSubmittingKyc.value = false;
    }
  }
}
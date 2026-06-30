import 'dart:io';
import 'package:demo_project/app/core/storage/storage_service.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/api_exception.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/features/profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final BaseApiService _baseApiService = BaseApiService();

  final isLoading = false.obs;
  final profileData = Rxn<ProfileModel>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  Rx<File?> selectedProfileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> pickProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedProfileImage.value = File(image.path);
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<void> fetchProfile() async {
    isLoading(true);
    try {
      final response = await _baseApiService.get(ApiEndpoints.profile);
      if (response != null && response['data'] != null) {
        final profile = ProfileModel.fromJson(response['data']);
        profileData.value = profile;
        
        fullNameController.text = profile.fullName;
        phoneController.text = profile.phoneNumber ?? '';
        addressController.text = profile.location ?? '';
      }
    } catch (e) {
      print("Error fetching profile: $e");
      if (e is ApiException) {
        print("ApiException details: ${e.message}");
      }
      Get.snackbar('Error', 'Failed to load profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isUpdating = false.obs;

Future<void> updateProfileData() async {
  isUpdating(true);
  try {
    final fields = <String, String>{};
    
    if (fullNameController.text.isNotEmpty) {
      fields['full_name'] = fullNameController.text;
    }
    if (phoneController.text.isNotEmpty) {
      fields['phone_number'] = phoneController.text;
    }
    if (profileData.value?.department != null && profileData.value!.department!.isNotEmpty) {
      fields['department'] = profileData.value!.department!;
    }
    if (addressController.text.isNotEmpty) {
      fields['location'] = addressController.text;
    }

    final files = <String, File>{};
    if (selectedProfileImage.value != null) {
      files['profile_image'] = selectedProfileImage.value!;
    }

    await _baseApiService.patchMultipart(
      ApiEndpoints.updateProfile,
      fields: fields,
      files: files.isNotEmpty ? files : null,
    );

   
    Get.back();
    await fetchProfile();

  
    await Future.delayed(const Duration(milliseconds: 300));

    Get.snackbar(
      "Success",
      "Profile updated successfully",
      backgroundColor: const Color(0xFF22C55E),
      colorText: const Color(0xFFFFFFFF),
      duration: const Duration(seconds: 3),
    );

  } catch (e) {
    print("Error updating profile: $e");
    if (e is ApiException) {
      print("ApiException details: ${e.message}");
    }
    Get.snackbar('Error', 'Failed to update profile: $e');
  } finally {
    isUpdating(false);
  }
}

  Future<void> logout() async {
    try {
      await _baseApiService.post(ApiEndpoints.logout);
    } catch (e) {
      print("Logout API error: $e");
    } finally {
      final storage = StorageService();
      await storage.removeToken();
      await storage.removeUserId();
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
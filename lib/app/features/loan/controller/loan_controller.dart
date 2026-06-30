import 'dart:io';

import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/features/loan/model/loan_type_model.dart';
import 'package:demo_project/app/features/loan/view/application_submitted.dart';
import 'package:demo_project/app/features/appMain/view/app_main_page.dart';
import 'package:demo_project/app/features/loan/view/load_apply_step1.dart';
import 'package:demo_project/app/features/loan/view/loan_apply_step2.dart';
import 'package:demo_project/app/features/loan/view/loan_apply_step3.dart';
import 'package:demo_project/app/features/loan/view/loan_apply_step4.dart';
import 'package:demo_project/app/features/loan/view/loan_apply_step5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:demo_project/app/core/storage/storage_service.dart';
import 'package:demo_project/app/core/config/environment.dart';

class LoanController extends GetxController {
  final BaseApiService _baseApiService = BaseApiService();
  
  final isLoading = false.obs;
  final isSubmitting = false.obs;

  final loanTypes = <LoanTypeModel>[].obs;
  final selectedLoanType = Rxn<LoanTypeModel>();
  final currentLoanApplicationId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLoanTypes();
  }

  Future<void> fetchLoanTypes() async {
    isLoading(true);

    try {
      final response = await _baseApiService.get(ApiEndpoints.customerLoadType);
      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        loanTypes.value = data.map((e) => LoanTypeModel.fromJson(e)).toList();
        
        // Optionally pre-select the first one if there are any
        if (loanTypes.isNotEmpty) {
          selectedLoanType.value = loanTypes.first;
        }
      }
    } catch (e) {
      print("Error fetching loan types: $e");
    } finally {
      isLoading(false);
    }
  }

  final loanAmountController = TextEditingController();
  final loanTermController = TextEditingController();
  final notesController = TextEditingController();

  // Step 2 Controllers
  final propertyValueController = TextEditingController();
  final mortgageBalanceController = TextEditingController();
  final mortgagePaymentController = TextEditingController();
  final mortgageLenderController = TextEditingController();
  final termRemainingController = TextEditingController();
  final interestRateController = TextEditingController();

  // Step 3 Controllers
  final annualIncomeController = TextEditingController();
  final selectedEmploymentType = 'Employed'.obs;

  // Step 4 Variables
  final hasCcj = true.obs;
  final hasDefaults = false.obs;
  final hasActiveDmp = true.obs;
  final hasActiveIva = false.obs;

  // Step 5 Data
  final loanApplicationDetails = <String, dynamic>{}.obs;

  // Step 6 Data
  final step6Data = <String, dynamic>{}.obs;

 

  @override
  void onClose() {
    loanAmountController.dispose();
    loanTermController.dispose();
    notesController.dispose();
    propertyValueController.dispose();
    mortgageBalanceController.dispose();
    mortgagePaymentController.dispose();
    mortgageLenderController.dispose();
    termRemainingController.dispose();
    interestRateController.dispose();
    annualIncomeController.dispose();
    super.onClose();
  }

  void selectLoanType(LoanTypeModel type) {
    selectedLoanType.value = type;
  }

  Future<void> createLoanApplication() async {
    final loanTypeId = selectedLoanType.value?.id;
    if (loanTypeId == null) {
      Get.snackbar("Error", "Please select a loan type first", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isSubmitting(true);

    try {
      final body = {
        "loanTypeId": loanTypeId
      };

      final response = await _baseApiService.post(
        ApiEndpoints.createLoanEndPoint,
        body: body,
      );

      if (response != null && response['data'] != null && response['data']['id'] != null) {
        currentLoanApplicationId.value = response['data']['id'];
        Get.snackbar("Success", "Loan application created successfully", backgroundColor: Colors.green, colorText: Colors.white);
        Get.to(() => const LoanApplyStep1());
      } else {
        Get.snackbar("Error", "Failed to create loan application", backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      if (!isClosed) isSubmitting(false);
    }
  }

  Future<void> submitStep1() async {
    final applicationId = currentLoanApplicationId.value;
    if (applicationId.isEmpty) {
      Get.snackbar("Error", "No active loan application draft found", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isSubmitting(true);

    final body = {
      "loanAmount": loanAmountController.text,
      "loanTerm": loanTermController.text,
      "notes": notesController.text,
      "currentStep": 2,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final endpoint = ApiEndpoints.updateLoanApplication(applicationId);
      print("===== SUBMIT STEP 1 REQUEST =====");
      print("URL: $endpoint");
      print("Body: $body");
      
      final response = await _baseApiService.patch(
        endpoint,
        body: body,
        extraHeaders: headers,
      );

      print("===== SUBMIT STEP 1 RESPONSE =====");
      print(response);
      
      Get.snackbar("Success", "Step 1 submitted successfully", backgroundColor: Colors.green, colorText: Colors.white);
      Get.to(() => const LoanApplyStep2());
    } catch (e) {
      print("===== SUBMIT STEP 1 ERROR =====");
      print(e.toString());
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      if (!isClosed) isSubmitting(false);
    }
  }
  Future<void> submitStep2() async {
    final applicationId = currentLoanApplicationId.value;
    if (applicationId.isEmpty) {
      Get.snackbar("Error", "No active loan application draft found", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isSubmitting(true);

    final body = {
      "propertyValue": propertyValueController.text,
      "mortgageBalance": mortgageBalanceController.text,
      "mortgagePayment": mortgagePaymentController.text,
      "mortgageLender": mortgageLenderController.text,
      "termRemaining": termRemainingController.text,
      "interestRate": interestRateController.text,
      "currentStep": 3,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final endpoint = ApiEndpoints.updateLoanApplication(applicationId);
      print("===== SUBMIT STEP 2 REQUEST =====");
      print("URL: $endpoint");
      print("Body: $body");
      
      final response = await _baseApiService.patch(
        endpoint,
        body: body,
        extraHeaders: headers,
      );

      print("===== SUBMIT STEP 2 RESPONSE =====");
      print(response);
      
      Get.snackbar("Success", "Step 2 submitted successfully", backgroundColor: Colors.green, colorText: Colors.white);
      Get.to(() =>  LoanApplyStep3());
    } catch (e) {
      print("===== SUBMIT STEP 2 ERROR =====");
      print(e.toString());
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      if (!isClosed) isSubmitting(false);
    }
  }

  Future<void> submitStep3() async {
    final applicationId = currentLoanApplicationId.value;
    if (applicationId.isEmpty) {
      Get.snackbar("Error", "No active loan application draft found", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isSubmitting(true);

    final body = {
      "employmentType": selectedEmploymentType.value.toLowerCase(),
      "annualIncome": annualIncomeController.text,
      "currentStep": 4,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final endpoint = ApiEndpoints.updateLoanApplication(applicationId);
      print("===== SUBMIT STEP 3 REQUEST =====");
      print("URL: $endpoint");
      print("Body: $body");
      
      final response = await _baseApiService.patch(
        endpoint,
        body: body,
        extraHeaders: headers,
      );

      print("===== SUBMIT STEP 3 RESPONSE =====");
      print(response);
      
      Get.snackbar("Success", "Step 3 submitted successfully", backgroundColor: Colors.green, colorText: Colors.white);
      Get.to(() =>  LoanApplyStep4());
    } catch (e) {
      print("===== SUBMIT STEP 3 ERROR =====");
      print(e.toString());
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      if (!isClosed) isSubmitting(false);
    }
  }

  Future<void> submitStep4() async {
    final applicationId = currentLoanApplicationId.value;
    if (applicationId.isEmpty) {
      Get.snackbar("Error", "No active loan application draft found", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isSubmitting(true);

    final body = {
      "hasCcj": hasCcj.value,
      "hasDefaults": hasDefaults.value,
      "hasActiveDmp": hasActiveDmp.value,
      "hasActiveIva": hasActiveIva.value,
      "currentStep": 5,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final endpoint = ApiEndpoints.updateLoanApplication(applicationId);
      print("===== SUBMIT STEP 4 REQUEST =====");
      print("URL: $endpoint");
      print("Body: $body");
      
      final response = await _baseApiService.patch(
        endpoint,
        body: body,
        extraHeaders: headers,
      );

      print("===== SUBMIT STEP 4 RESPONSE =====");
      print(response);
      
      Get.snackbar("Success", "Step 4 submitted successfully", backgroundColor: Colors.green, colorText: Colors.white);
      await fetchLoanApplicationDetails();
      Get.to(() =>  LoanApplyStep5());
    } catch (e) {
      print("===== SUBMIT STEP 4 ERROR =====");
      print(e.toString());
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      if (!isClosed) isSubmitting(false);
    }
  }

  Future<void> fetchLoanApplicationDetails() async {
    final applicationId = currentLoanApplicationId.value;
    if (applicationId.isEmpty) return;

    isLoading(true);
    try {
      final endpoint = ApiEndpoints.updateLoanApplication(applicationId);
      final response = await _baseApiService.get(endpoint);
      if (response != null && response['data'] != null) {
        loanApplicationDetails.value = response['data'];
      }
    } catch (e) {
      print("Error fetching application details: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> finalApplicationSubmit() async {
    final applicationId = currentLoanApplicationId.value;
    if (applicationId.isEmpty) {
      Get.snackbar("Error", "No active loan application draft found", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isSubmitting(true);
    try {
      final endpoint = ApiEndpoints.submitedApplicationEndPoint(applicationId);
      final response = await _baseApiService.post(endpoint);
      
      if (response != null && response['success'] == true) {
        Get.snackbar("Success", "Application submitted successfully", backgroundColor: Colors.green, colorText: Colors.white);
        Get.to(() => const ApplicationSubmitted());
      } else {
        Get.snackbar("Error", response?['message'] ?? "Submission failed", backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print("Error submitting application: $e");
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      if (!isClosed) isSubmitting(false);
    }
  }

  Future<void> fetchStep6Data() async {
    final applicationId = currentLoanApplicationId.value;
    if (applicationId.isEmpty) return;

    isLoading(true);
    try {
      final endpoint = ApiEndpoints.updateLoanApplicationStep6(applicationId);
      final response = await _baseApiService.get(endpoint);
      if (response != null && response['data'] != null) {
        step6Data.value = response['data'];
      }
    } catch (e) {
      print("Error fetching step 6 data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<bool> uploadDocument(String documentType, File file) async {
    final applicationId = currentLoanApplicationId.value;
    if (applicationId.isEmpty) {
      Get.snackbar("Error", "No application ID found", backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    
    isSubmitting(true);
    try {
      final endpoint = ApiEndpoints.submitDocument(applicationId);
      
      await _baseApiService.postMultipart(
        endpoint,
        fields: {
          'documentType': documentType,
        },
        files: {
          'file': file,
        },
      );

      Get.snackbar("Success", "Document uploaded successfully", backgroundColor: Colors.green, colorText: Colors.white);
      return true;
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      isSubmitting(false);
    }
  }

  Future<void> completeDocument() async {
    final applicationId = currentLoanApplicationId.value;
    if (applicationId.isEmpty) {
      Get.snackbar("Error", "No application ID found", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isSubmitting(true);
    try {
      final endpoint = ApiEndpoints.completeDocument(applicationId);
      final response = await _baseApiService.post(endpoint, body: {});
      if (response != null) {
        Get.snackbar("Success", "Documents uploaded successfully", backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAll(() => const AppMainPage());
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isSubmitting(false);
    }
  }
}
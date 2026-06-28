import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/features/loan/model/loan_type_model.dart';
import 'package:demo_project/app/features/loan/view/loan_apply_step2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanController extends GetxController {
  final BaseApiService _baseApiService = BaseApiService();
  
  final isLoading = false.obs;
  final loanTypes = <LoanTypeModel>[].obs;
  final selectedLoanType = Rxn<LoanTypeModel>();

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

  final isSubmitting = false.obs;

  @override
  void onClose() {
    loanAmountController.dispose();
    loanTermController.dispose();
    notesController.dispose();
    super.onClose();
  }

  void selectLoanType(LoanTypeModel type) {
    selectedLoanType.value = type;
  }

  Future<void> submitStep1() async {
    final loanTypeId = selectedLoanType.value?.id;
    if (loanTypeId == null) {
      Get.snackbar("Error", "Please select a loan type first", backgroundColor: Colors.red, colorText: Colors.white);
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
      final endpoint = ApiEndpoints.updateLoanApplication(loanTypeId);
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
      
      Get.to(() => const LoanApplyStep2());
    } catch (e) {
      print("===== SUBMIT STEP 1 ERROR =====");
      print(e.toString());
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      if (!isClosed) isSubmitting(false);
    }
  }
}
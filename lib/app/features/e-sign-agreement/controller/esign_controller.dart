import 'dart:io';
import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/api_exception.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/features/e-sign-agreement/model/agreement_details_model.dart';
import 'package:demo_project/app/features/e-sign-agreement/model/my_loan_model.dart';
import 'package:get/get.dart';

class EsignController extends GetxController {
  final BaseApiService _baseApiService = BaseApiService();
  
  final isLoading = false.obs;
  final myLoans = <MyLoanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyLoans();
  }

  Future<void> fetchMyLoans() async {
    isLoading(true);
    try {
      final response = await _baseApiService.get(ApiEndpoints.allGetMyLoanEndPoint);
      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        myLoans.value = data.map((e) => MyLoanModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error fetching loans: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<AgreementDetailsModel?> fetchAgreementDetails(String id) async {
    try {
      final response = await _baseApiService.get(ApiEndpoints.previewGetAgreement(id));
      if (response != null && response['data'] != null) {
        return AgreementDetailsModel.fromJson(response['data']);
      }
    } catch (e) {
      print("Error fetching agreement details: $e");
    }
    return null;
  }

  Future<bool> submitSignature(String id, File signatureFile, bool acceptedTerms) async {
    isLoading(true);
    try {
      final response = await _baseApiService.postMultipart(
        ApiEndpoints.submitSignutare(id),
        fields: {
          'accepted_terms': acceptedTerms.toString(),
        },
        files: {
          'signature_image': signatureFile,
        },
      );
      if (response != null && response['success'] == true) {
        return true;
      }
    } catch (e) {
      if (e is ApiException) {
        print("API Error: ${e.statusCode} => ${e.data}");
      } else {
        print("Error submitting signature: $e");
      }
    } finally {
      isLoading(false);
    }
    return false;
  }
}
import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/features/refer/model/referral_model.dart';
import 'package:get/get.dart';

class ReferController extends GetxController {
  final BaseApiService _baseApiService = BaseApiService();

  final RxBool isLoading = false.obs;
  final Rxn<ReferralData> referralData = Rxn<ReferralData>();

  @override
  void onInit() {
    super.onInit();
    fetchReferralDashboard();
  }

  Future<void> fetchReferralDashboard() async {
    isLoading(true);
    try {
      final response = await _baseApiService.get(ApiEndpoints.referralDashboard);

      if (response != null) {
        final referralResponse = ReferralResponse.fromJson(response);
        referralData.value = referralResponse.data;
      }
    } catch (e) {
      print("Error fetching referral dashboard: $e");
      Get.snackbar('Error', 'Failed to load referral dashboard');
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshDashboard() async {
    await fetchReferralDashboard();
  }
}
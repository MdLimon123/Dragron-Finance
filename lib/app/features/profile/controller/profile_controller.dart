import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/features/profile/model/profile_model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final BaseApiService _baseApiService = BaseApiService();

  final isLoading = false.obs;
  final profileData = Rxn<ProfileModel>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading(true);
    try {
      final response = await _baseApiService.get(ApiEndpoints.profile);
      if (response != null && response['data'] != null) {
        profileData.value = ProfileModel.fromJson(response['data']);
      }
    } catch (e) {
      print("Error fetching profile: $e");
    } finally {
      if (!isClosed) isLoading(false);
    }
  }
}
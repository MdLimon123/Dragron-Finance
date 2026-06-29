import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/features/myLoan/model/my_loan_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLoanController extends GetxController {
  final BaseApiService _baseApiService = BaseApiService();

  final RxString selectedTab = 'All'.obs;
  final List<String> tabs = ['All', 'Active', 'In Review', 'Completed'];

  final RxBool isLoading = false.obs;
  final RxList<MyLoanModel> loans = <MyLoanModel>[].obs;
  final Rxn<MyLoanSummaryModel> summary = Rxn<MyLoanSummaryModel>();

  int currentPage = 1;
  int limit = 10;
  bool hasMoreData = true;
  final RxBool isFetchingMore = false.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    fetchMyLoans();
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
      fetchMyLoans(isLoadMore: true);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
    fetchMyLoans();
  }

  Future<void> fetchMyLoans({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (!hasMoreData || isFetchingMore.value) return;
      isFetchingMore(true);
      currentPage++;
    } else {
      isLoading(true);
      currentPage = 1;
      hasMoreData = true;
      loans.clear();
    }

    try {
      String status = '';
      if (selectedTab.value == 'Active') status = 'active';
      if (selectedTab.value == 'In Review') status = 'under_review';
      if (selectedTab.value == 'Completed') status = 'completed';

      Map<String, dynamic> queryParams = {
        'page': currentPage.toString(),
        'limit': limit.toString(),
      };
      
      if (status.isNotEmpty) {
        queryParams['status'] = status;
      }

      final response = await _baseApiService.get(
        ApiEndpoints.getMyLoanEndPoint,
        queryParams: queryParams,
      );

      if (response != null) {
        final myLoanResponse = MyLoanResponse.fromJson(response);
        
        if (isLoadMore) {
          loans.addAll(myLoanResponse.data);
        } else {
          loans.assignAll(myLoanResponse.data);
          summary.value = myLoanResponse.summary;
        }
        
        hasMoreData = currentPage < myLoanResponse.totalPage;
      }
    } catch (e) {
      print("Error fetching loans: $e");
      if (!isLoadMore) Get.snackbar('Error', 'Failed to load loans');
      if (isLoadMore) currentPage--;
    } finally {
      if (isLoadMore) {
        isFetchingMore(false);
      } else {
        isLoading(false);
      }
    }
  }
}
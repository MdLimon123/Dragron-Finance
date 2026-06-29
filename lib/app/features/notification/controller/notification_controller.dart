import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/features/notification/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final BaseApiService _baseApiService = BaseApiService();

  final RxBool isLoading = false.obs;
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final Rxn<NotificationMeta> meta = Rxn<NotificationMeta>();

  int currentPage = 1;
  int limit = 20;
  bool hasMoreData = true;
  final RxBool isFetchingMore = false.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    fetchNotifications();
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
      fetchNotifications(isLoadMore: true);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchNotifications({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (!hasMoreData || isFetchingMore.value) return;
      isFetchingMore(true);
      currentPage++;
    } else {
      isLoading(true);
      currentPage = 1;
      hasMoreData = true;
      notifications.clear();
    }

    try {
      Map<String, dynamic> queryParams = {
        'page': currentPage.toString(),
        'limit': limit.toString(),
      };

      final response = await _baseApiService.get(
        ApiEndpoints.notification,
        queryParams: queryParams,
      );

      if (response != null) {
        final notificationResponse = NotificationResponse.fromJson(response);
        
        if (isLoadMore) {
          notifications.addAll(notificationResponse.data);
        } else {
          notifications.assignAll(notificationResponse.data);
        }
        meta.value = notificationResponse.meta;
        
        hasMoreData = notificationResponse.meta.hasNext;
      }
    } catch (e) {
      print("Error fetching notifications: $e");
      if (!isLoadMore) Get.snackbar('Error', 'Failed to load notifications');
      if (isLoadMore) currentPage--;
    } finally {
      if (isLoadMore) {
        isFetchingMore(false);
      } else {
        isLoading(false);
      }
    }
  }

  Future<void> refreshNotifications() async {
    await fetchNotifications();
  }
}
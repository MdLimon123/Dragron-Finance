import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/features/book-a-call/model/book_call_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookCallController extends GetxController {
  final BaseApiService _baseApiService = BaseApiService();

  final RxBool isLoading = false.obs;
  final Rxn<BookCallData> bookCallData = Rxn<BookCallData>();

  // State
  final Rx<DateTime> focusedMonth = DateTime.now().obs;
  final Rxn<DateTime> selectedDate = Rxn<DateTime>(DateTime.now());
  final RxnString selectedTime = RxnString();
  final RxInt selectedCallType = 0.obs; 

  final RxList<String> timeSlots = <String>[].obs;
  final RxList<String> unavailableTimes = <String>[].obs;

  final RxBool isSubmitting = false.obs;
  final TextEditingController noteController = TextEditingController();

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    selectedDate.value = DateTime(now.year, now.month, now.day);
    focusedMonth.value = DateTime(now.year, now.month);
    fetchBookCallData();
  }

  void onDateSelected(DateTime date) {
    selectedDate.value = date;
    fetchBookCallData();
  }

  void onCallTypeSelected(int index) {
    selectedCallType.value = index;
    fetchBookCallData();
  }

  Future<void> fetchBookCallData() async {
    isLoading(true);
    try {
      final dateStr = selectedDate.value != null 
        ? DateFormat('yyyy-MM-dd').format(selectedDate.value!) 
        : DateFormat('yyyy-MM-dd').format(DateTime.now());
      
      final callTypeStr = selectedCallType.value == 0 ? 'phone_call' : 'live_chat';

    
      final endpoint = "${ApiEndpoints.getBookApiEndPoint}?date=$dateStr&call_type=$callTypeStr";
      final response = await _baseApiService.get(endpoint);

      if (response != null) {
        final bookCallResponse = BookCallResponse.fromJson(response);
        if (bookCallResponse.data != null) {
          bookCallData.value = bookCallResponse.data;
         
          timeSlots.clear();
          unavailableTimes.clear();

          for (var slot in bookCallResponse.data!.slots) {
            timeSlots.add(slot.label);
            if (!slot.isAvailable) {
              unavailableTimes.add(slot.label);
            }
          }
          
      
          if (timeSlots.isNotEmpty && (selectedTime.value == null || unavailableTimes.contains(selectedTime.value))) {
             final firstAvailable = timeSlots.firstWhere((t) => !unavailableTimes.contains(t), orElse: () => '');
             if (firstAvailable.isNotEmpty) {
               selectedTime.value = firstAvailable;
             }
          }
        }
      }
    } catch (e) {
      print("Error fetching book call data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> submitBooking(Function onSuccess) async {
    final managerId = bookCallData.value?.caseManager?.id;
    final date = selectedDate.value;
    final time = selectedTime.value;
    
    if (managerId == null || date == null || time == null || time.isEmpty) {
      Get.snackbar("Error", "Please select a date and time slot",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isSubmitting(true);
    try {
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      final callTypeStr = selectedCallType.value == 0 ? 'phone_call' : 'live_chat';
      
      // Look up the underlying 24h time format string from the slots based on the selected label
      final slot = bookCallData.value?.slots.firstWhere((s) => s.label == time, orElse: () => BookCallSlot(time: '', label: '', isAvailable: false));
      final timeStr = slot?.time ?? '';

      final Map<String, dynamic> requestBody = {
        "manager_id": managerId,
        "call_type": callTypeStr,
        "date": dateStr,
        "time": timeStr,
        "note": noteController.text.trim(),
      };

      final response = await _baseApiService.post(
        ApiEndpoints.submitBookingEndPoint,
        body: requestBody,
      );

      if (response != null && response['success'] == true) {
        Get.snackbar("Success", response['message'] ?? "Appointment booked successfully",
            snackPosition: SnackPosition.BOTTOM);
        onSuccess();
      } else {
        Get.snackbar("Error", response?['message'] ?? "Failed to book appointment",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("Error submitting booking: $e");
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSubmitting(false);
    }
  }
}
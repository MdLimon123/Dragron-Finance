import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/core/network/socket_manager.dart';
import 'package:demo_project/app/core/storage/storage_service.dart';
import 'package:demo_project/app/core/utils/logger.dart';
import 'package:demo_project/app/features/liveChat/model/chat_conversation_model.dart';
import 'package:demo_project/app/features/liveChat/model/chat_message_model.dart';
import 'package:demo_project/app/features/liveChat/view/chat_page.dart';

class LiveChatController extends GetxController {
  final BaseApiService _apiService = BaseApiService();
  final StorageService _storageService = StorageService();

  RxBool isLoading = false.obs;
  RxBool isChatLoading = false.obs;
  
  RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  Rx<ChatConversationModel?> currentConversation = Rx<ChatConversationModel?>(null);
  
  RxBool isAdminTyping = false.obs;
  
  String get currentUserId => _storageService.getUserId() ?? '';

  StreamSubscription? _socketSubscription;
  Timer? _typingTimer;
  bool _isTypingSent = false;

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    _socketSubscription?.cancel();
    SocketManager.disconnect();
    super.onClose();
  }

  void onMessageChanged(String value) {
    if (value.isNotEmpty && !_isTypingSent) {
      _sendTypingStatus(true);
      _isTypingSent = true;
    }
    
    // Reset typing status after a delay
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      _sendTypingStatus(false);
      _isTypingSent = false;
    });
  }

  void _sendTypingStatus(bool isTyping) {
    SocketManager.emit({
      "action": "typing",
      "isTyping": isTyping
    });
  }

  Future<void> startNewChat(String title, String messageText) async {
    if (currentConversation.value != null) {
      // Resume existing chat
      await connectToChat(currentConversation.value!.id);
      Get.to(() => const ChatPage());
      return;
    }

    try {
      isLoading.value = true;
      Get.dialog(
        const Center(child: CircularProgressIndicator(color: Color(0xFFA41F13))),
        barrierDismissible: false,
      );
      final response = await _apiService.post(
        ApiEndpoints.createRoomIdEndPoint,
        body: {
          "title": title,
          "message": messageText,
        },
      );
      
      Get.back(); // close dialog after response

      if (response['success'] == true && response['data'] != null) {
        final conversation = ChatConversationModel.fromJson(response['data']);
        currentConversation.value = conversation;
        
        // Connect to socket and fetch messages
        await connectToChat(conversation.id);
        
        // Navigate to chat screen
        Get.to(() => const ChatPage());
      } else {
        Get.snackbar("Error", response['message'] ?? "Failed to create chat");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back(); // close dialog on error
      AppLogger.error('Failed to start chat', error: e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> connectToChat(String roomId) async {
    final token = _storageService.getToken() ?? '';
    
    // Connect Socket
    SocketManager.init(roomId, token);
    _listenToSocket();
    
    // Fetch old messages
    await _fetchOldMessages(roomId);
  }

  Future<void> _fetchOldMessages(String roomId) async {
    try {
      isChatLoading.value = true;
      final response = await _apiService.get(
        ApiEndpoints.getOldAllMessage(roomId),
      );
      
      if (response['success'] == true && response['data'] != null) {
        final messagesData = response['data']['messages'] as List?;
        if (messagesData != null) {
          messages.value = messagesData
              .map((e) => ChatMessageModel.fromJson(e))
              .toList();
          
          _scrollToBottom();
        }
      }
    } catch (e) {
      AppLogger.error('Failed to fetch messages', error: e);
    } finally {
      isChatLoading.value = false;
    }
  }

  void _listenToSocket() {
    _socketSubscription?.cancel();
    _socketSubscription = SocketManager.messageStream.listen((dataString) {
      try {
        final data = jsonDecode(dataString);
        
        if (data['type'] == 'message' && data['message'] != null) {
          final newMessage = ChatMessageModel.fromJson(data['message']);
          messages.add(newMessage);
          _scrollToBottom();
        } else if (data['action'] == 'typing') {
          isAdminTyping.value = data['isTyping'] ?? false;
          if (isAdminTyping.value) {
            _scrollToBottom();
          }
        }
      } catch (e) {
        AppLogger.error('Failed to parse socket message', error: e);
      }
    });
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    SocketManager.emit({
      "action": "send_message",
      "message": text,
    });
    
    messageController.clear();
    _sendTypingStatus(false);
    _isTypingSent = false;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

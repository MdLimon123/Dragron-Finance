import 'chat_conversation_model.dart';

class ChatMessageModel {
  final String id;
  final String conversationId;
  final ChatUserModel? sender;
  final String messageType;
  final String message;
  final String? attachmentUrl;
  final String? readAt;
  final String createdAt;

  ChatMessageModel({
    required this.id,
    required this.conversationId,
    this.sender,
    required this.messageType,
    required this.message,
    this.attachmentUrl,
    this.readAt,
    required this.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      conversationId: json['conversationId'] ?? '',
      sender: json['sender'] != null ? ChatUserModel.fromJson(json['sender']) : null,
      messageType: json['messageType'] ?? 'text',
      message: json['message'] ?? '',
      attachmentUrl: json['attachmentUrl'],
      readAt: json['readAt'],
      createdAt: json['createdAt'] ?? '',
    );
  }
}

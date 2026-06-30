class ChatConversationModel {
  final String id;
  final String title;
  final String status;
  final ChatUserModel? customer;
  final ChatUserModel? admin;
  final String? lastMessage;
  final String? lastMessageAt;
  final int unreadCount;
  final String? websocketUrl;
  final String createdAt;
  final String updatedAt;

  ChatConversationModel({
    required this.id,
    required this.title,
    required this.status,
    this.customer,
    this.admin,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
    this.websocketUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) {
    return ChatConversationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? '',
      customer: json['customer'] != null ? ChatUserModel.fromJson(json['customer']) : null,
      admin: json['admin'] != null ? ChatUserModel.fromJson(json['admin']) : null,
      lastMessage: json['lastMessage'],
      lastMessageAt: json['lastMessageAt'],
      unreadCount: json['unreadCount'] ?? 0,
      websocketUrl: json['websocketUrl'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class ChatUserModel {
  final String id;
  final String name;
  final String? email;
  final String? initials;
  final String role;
  final bool isAdmin;

  ChatUserModel({
    required this.id,
    required this.name,
    this.email,
    this.initials,
    required this.role,
    required this.isAdmin,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'],
      initials: json['initials'],
      role: json['role'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
    );
  }
}

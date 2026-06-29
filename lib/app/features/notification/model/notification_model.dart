class NotificationResponse {
  final bool success;
  final String message;
  final NotificationMeta meta;
  final List<NotificationModel> data;
  final String requestId;

  NotificationResponse({
    required this.success,
    required this.message,
    required this.meta,
    required this.data,
    required this.requestId,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      meta: json['meta'] != null ? NotificationMeta.fromJson(json['meta']) : NotificationMeta.empty(),
      data: json['data'] != null ? (json['data'] as List).map((i) => NotificationModel.fromJson(i)).toList() : [],
      requestId: json['requestId'] ?? '',
    );
  }
}

class NotificationMeta {
  final int unreadCount;
  final int total;
  final int page;
  final int limit;
  final bool hasNext;
  final NotificationFilters filters;

  NotificationMeta({
    required this.unreadCount,
    required this.total,
    required this.page,
    required this.limit,
    required this.hasNext,
    required this.filters,
  });

  factory NotificationMeta.empty() {
    return NotificationMeta(
      unreadCount: 0,
      total: 0,
      page: 1,
      limit: 20,
      hasNext: false,
      filters: NotificationFilters.empty(),
    );
  }

  factory NotificationMeta.fromJson(Map<String, dynamic> json) {
    return NotificationMeta(
      unreadCount: json['unreadCount'] ?? 0,
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 20,
      hasNext: json['hasNext'] ?? false,
      filters: json['filters'] != null ? NotificationFilters.fromJson(json['filters']) : NotificationFilters.empty(),
    );
  }
}

class NotificationFilters {
  final String status;
  final String type;
  final String search;

  NotificationFilters({
    required this.status,
    required this.type,
    required this.search,
  });

  factory NotificationFilters.empty() {
    return NotificationFilters(
      status: '',
      type: '',
      search: '',
    );
  }

  factory NotificationFilters.fromJson(Map<String, dynamic> json) {
    return NotificationFilters(
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      search: json['search'] ?? '',
    );
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type;
  final String typeLabel;
  final String priority;
  final String priorityLabel;
  final bool isRead;
  final String? readAt;
  final String createdAt;
  final String timeAgo;
  final NotificationAction? action;
  final NotificationMetadata? metadata;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.typeLabel,
    required this.priority,
    required this.priorityLabel,
    required this.isRead,
    this.readAt,
    required this.createdAt,
    required this.timeAgo,
    this.action,
    this.metadata,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      typeLabel: json['typeLabel'] ?? '',
      priority: json['priority'] ?? '',
      priorityLabel: json['priorityLabel'] ?? '',
      isRead: json['isRead'] ?? false,
      readAt: json['readAt'],
      createdAt: json['createdAt'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      action: json['action'] != null ? NotificationAction.fromJson(json['action']) : null,
      metadata: json['metadata'] != null ? NotificationMetadata.fromJson(json['metadata']) : null,
    );
  }
}

class NotificationAction {
  final String screen;
  final String api;
  final String objectId;
  final String objectType;

  NotificationAction({
    required this.screen,
    required this.api,
    required this.objectId,
    required this.objectType,
  });

  factory NotificationAction.fromJson(Map<String, dynamic> json) {
    return NotificationAction(
      screen: json['screen'] ?? '',
      api: json['api'] ?? '',
      objectId: json['objectId'] ?? '',
      objectType: json['objectType'] ?? '',
    );
  }
}

class NotificationMetadata {
  final String kycId;
  final String? applicationId;
  final String? applicationNumber;
  final String status;

  NotificationMetadata({
    required this.kycId,
    this.applicationId,
    this.applicationNumber,
    required this.status,
  });

  factory NotificationMetadata.fromJson(Map<String, dynamic> json) {
    return NotificationMetadata(
      kycId: json['kycId'] ?? '',
      applicationId: json['applicationId'],
      applicationNumber: json['applicationNumber'],
      status: json['status'] ?? '',
    );
  }
}
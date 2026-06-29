class BookCallResponse {
  final bool success;
  final String message;
  final BookCallData? data;

  BookCallResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory BookCallResponse.fromJson(Map<String, dynamic> json) {
    return BookCallResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? BookCallData.fromJson(json['data']) : null,
    );
  }
}

class BookCallData {
  final CaseManager? caseManager;
  final List<CallType> callTypes;
  final SelectedCall? selected;
  final List<BookCallSlot> slots;
  final Reminder? reminder;

  BookCallData({
    this.caseManager,
    required this.callTypes,
    this.selected,
    required this.slots,
    this.reminder,
  });

  factory BookCallData.fromJson(Map<String, dynamic> json) {
    return BookCallData(
      caseManager: json['caseManager'] != null ? CaseManager.fromJson(json['caseManager']) : null,
      callTypes: json['callTypes'] != null ? (json['callTypes'] as List).map((i) => CallType.fromJson(i)).toList() : [],
      selected: json['selected'] != null ? SelectedCall.fromJson(json['selected']) : null,
      slots: json['slots'] != null ? (json['slots'] as List).map((i) => BookCallSlot.fromJson(i)).toList() : [],
      reminder: json['reminder'] != null ? Reminder.fromJson(json['reminder']) : null,
    );
  }
}

class Reminder {
  final bool enabled;
  final int minutesBefore;
  final String message;

  Reminder({
    required this.enabled,
    required this.minutesBefore,
    required this.message,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      enabled: json['enabled'] ?? false,
      minutesBefore: json['minutesBefore'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}

class CaseManager {
  final String id;
  final String name;
  final String title;
  final String initials;
  final String avatarUrl;
  final String speciality;

  CaseManager({
    required this.id,
    required this.name,
    required this.title,
    required this.initials,
    required this.avatarUrl,
    required this.speciality,
  });

  factory CaseManager.fromJson(Map<String, dynamic> json) {
    return CaseManager(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      initials: json['initials'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      speciality: json['speciality'] ?? '',
    );
  }
}

class CallType {
  final String value;
  final String label;

  CallType({
    required this.value,
    required this.label,
  });

  factory CallType.fromJson(Map<String, dynamic> json) {
    return CallType(
      value: json['value'] ?? '',
      label: json['label'] ?? '',
    );
  }
}

class SelectedCall {
  final String managerId;
  final String date;
  final String dateLabel;
  final String callType;
  final String callTypeLabel;

  SelectedCall({
    required this.managerId,
    required this.date,
    required this.dateLabel,
    required this.callType,
    required this.callTypeLabel,
  });

  factory SelectedCall.fromJson(Map<String, dynamic> json) {
    return SelectedCall(
      managerId: json['managerId'] ?? '',
      date: json['date'] ?? '',
      dateLabel: json['dateLabel'] ?? '',
      callType: json['callType'] ?? '',
      callTypeLabel: json['callTypeLabel'] ?? '',
    );
  }
}

class BookCallSlot {
  final String time;
  final String label;
  final bool isAvailable;

  BookCallSlot({
    required this.time,
    required this.label,
    required this.isAvailable,
  });

  factory BookCallSlot.fromJson(Map<String, dynamic> json) {
    return BookCallSlot(
      time: json['time'] ?? '',
      label: json['label'] ?? '',
      isAvailable: json['isAvailable'] ?? false,
    );
  }
}

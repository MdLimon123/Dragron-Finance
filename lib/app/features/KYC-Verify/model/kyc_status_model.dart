class KycResponse {
  final bool? success;
  final String? message;
  final KycStatusModel? data;

  KycResponse({
    this.success,
    this.message,
    this.data,
  });

  factory KycResponse.fromJson(Map<String, dynamic> json) {
    return KycResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? KycStatusModel.fromJson(json['data']) : null,
    );
  }
}

class KycStatusModel {
  final String? id;
  final String? status;
  final String? statusLabel;
  final String? statusBadgeType;
  final ScreenData? screen;
  final List<KycStep>? steps;

  KycStatusModel({
    this.id,
    this.status,
    this.statusLabel,
    this.statusBadgeType,
    this.screen,
    this.steps,
  });

  factory KycStatusModel.fromJson(Map<String, dynamic> json) {
    return KycStatusModel(
      id: json['id'],
      status: json['status'],
      statusLabel: json['statusLabel'],
      statusBadgeType: json['statusBadgeType'],
      screen: json['screen'] != null ? ScreenData.fromJson(json['screen']) : null,
      steps: json['steps'] != null ? (json['steps'] as List).map((i) => KycStep.fromJson(i)).toList() : null,
    );
  }
}

class ScreenData {
  final String? title;
  final String? subtitle;
  final String? underReviewTitle;
  final String? underReviewMessage;

  ScreenData({
    this.title,
    this.subtitle,
    this.underReviewTitle,
    this.underReviewMessage,
  });

  factory ScreenData.fromJson(Map<String, dynamic> json) {
    return ScreenData(
      title: json['title'],
      subtitle: json['subtitle'],
      underReviewTitle: json['underReviewTitle'],
      underReviewMessage: json['underReviewMessage'],
    );
  }
}

class KycStep {
  final int? step;
  final String? key;
  final String? title;
  final String? status;

  KycStep({
    this.step,
    this.key,
    this.title,
    this.status,
  });

  factory KycStep.fromJson(Map<String, dynamic> json) {
    return KycStep(
      step: json['step'],
      key: json['key'],
      title: json['title'],
      status: json['status'],
    );
  }
}
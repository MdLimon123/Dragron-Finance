class ReferralResponse {
  final bool success;
  final String message;
  final ReferralData? data;

  ReferralResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ReferralResponse.fromJson(Map<String, dynamic> json) {
    return ReferralResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ReferralData.fromJson(json['data']) : null,
    );
  }
}

class ReferralData {
  final String screenTitle;
  final ReferralHero? hero;
  final ReferralDetails? referral;
  final ReferralShareVia? shareVia;
  final ReferralProgress? progress;
  final ReferralStats? stats;
  final List<ReferralUser> referrals;

  ReferralData({
    required this.screenTitle,
    this.hero,
    this.referral,
    this.shareVia,
    this.progress,
    this.stats,
    required this.referrals,
  });

  factory ReferralData.fromJson(Map<String, dynamic> json) {
    return ReferralData(
      screenTitle: json['screenTitle'] ?? '',
      hero: json['hero'] != null ? ReferralHero.fromJson(json['hero']) : null,
      referral: json['referral'] != null ? ReferralDetails.fromJson(json['referral']) : null,
      shareVia: json['shareVia'] != null ? ReferralShareVia.fromJson(json['shareVia']) : null,
      progress: json['progress'] != null ? ReferralProgress.fromJson(json['progress']) : null,
      stats: json['stats'] != null ? ReferralStats.fromJson(json['stats']) : null,
      referrals: json['referrals'] != null
          ? (json['referrals'] as List).map((i) => ReferralUser.fromJson(i)).toList()
          : [],
    );
  }
}

class ReferralHero {
  final String programTitle;
  final String title;
  final String subtitle;
  final int totalInvited;

  ReferralHero({
    required this.programTitle,
    required this.title,
    required this.subtitle,
    required this.totalInvited,
  });

  factory ReferralHero.fromJson(Map<String, dynamic> json) {
    return ReferralHero(
      programTitle: json['programTitle'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      totalInvited: json['totalInvited'] ?? 0,
    );
  }
}

class ReferralDetails {
  final String code;
  final String link;
  final String copyText;

  ReferralDetails({
    required this.code,
    required this.link,
    required this.copyText,
  });

  factory ReferralDetails.fromJson(Map<String, dynamic> json) {
    return ReferralDetails(
      code: json['code'] ?? '',
      link: json['link'] ?? '',
      copyText: json['copyText'] ?? '',
    );
  }
}

class ReferralShareVia {
  final String whatsapp;
  final String email;
  final String shareText;

  ReferralShareVia({
    required this.whatsapp,
    required this.email,
    required this.shareText,
  });

  factory ReferralShareVia.fromJson(Map<String, dynamic> json) {
    return ReferralShareVia(
      whatsapp: json['whatsapp'] ?? '',
      email: json['email'] ?? '',
      shareText: json['shareText'] ?? '',
    );
  }
}

class ReferralProgress {
  final String title;
  final int goal;
  final int joined;
  final int pending;
  final int invited;
  final int percentage;
  final String remainingText;

  ReferralProgress({
    required this.title,
    required this.goal,
    required this.joined,
    required this.pending,
    required this.invited,
    required this.percentage,
    required this.remainingText,
  });

  factory ReferralProgress.fromJson(Map<String, dynamic> json) {
    return ReferralProgress(
      title: json['title'] ?? '',
      goal: json['goal'] ?? 0,
      joined: json['joined'] ?? 0,
      pending: json['pending'] ?? 0,
      invited: json['invited'] ?? 0,
      percentage: json['percentage'] ?? 0,
      remainingText: json['remainingText'] ?? '',
    );
  }
}

class ReferralStats {
  final int totalInvited;
  final int joinedActive;
  final int pending;
  final int invited;
  final int goal;
  final int progressPercentage;
  final int remainingToGoal;

  ReferralStats({
    required this.totalInvited,
    required this.joinedActive,
    required this.pending,
    required this.invited,
    required this.goal,
    required this.progressPercentage,
    required this.remainingToGoal,
  });

  factory ReferralStats.fromJson(Map<String, dynamic> json) {
    return ReferralStats(
      totalInvited: json['totalInvited'] ?? 0,
      joinedActive: json['joinedActive'] ?? 0,
      pending: json['pending'] ?? 0,
      invited: json['invited'] ?? 0,
      goal: json['goal'] ?? 0,
      progressPercentage: json['progressPercentage'] ?? 0,
      remainingToGoal: json['remainingToGoal'] ?? 0,
    );
  }
}

class ReferralUser {
  final String name;
  final String date;
  final String status;
  final String initials;

  ReferralUser({
    required this.name,
    required this.date,
    required this.status,
    required this.initials,
  });

  factory ReferralUser.fromJson(Map<String, dynamic> json) {
    return ReferralUser(
      name: json['name'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      initials: json['initials'] ?? '',
    );
  }
}
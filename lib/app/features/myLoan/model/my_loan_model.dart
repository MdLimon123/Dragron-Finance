class MyLoanResponse {
  final List<MyLoanModel> data;
  final MyLoanSummaryModel? summary;
  final int totalPage;

  MyLoanResponse({required this.data, this.summary, required this.totalPage});

  factory MyLoanResponse.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List? ?? [];
    final meta = json['meta'] as Map<String, dynamic>?;
    final summaryJson = meta?['summary'] as Map<String, dynamic>?;
    final totalPage = meta?['totalPage'] ?? 1;

    return MyLoanResponse(
      data: dataList.map((e) => MyLoanModel.fromJson(e)).toList(),
      summary: summaryJson != null ? MyLoanSummaryModel.fromJson(summaryJson) : null,
      totalPage: totalPage,
    );
  }
}

class MyLoanSummaryModel {
  final int totalApplications;
  final int activeLoans;
  final int inReview;
  final int approved;

  MyLoanSummaryModel({
    required this.totalApplications,
    required this.activeLoans,
    required this.inReview,
    required this.approved,
  });

  factory MyLoanSummaryModel.fromJson(Map<String, dynamic> json) {
    return MyLoanSummaryModel(
      totalApplications: json['total_applications'] ?? 0,
      activeLoans: json['active_loans'] ?? 0,
      inReview: json['in_review'] ?? 0,
      approved: json['approved'] ?? 0,
    );
  }
}

class MyLoanModel {
  final String id;
  final String applicationNumber;
  final String loanType;
  final String? iconImageUrl;
  final String loanAmount;
  final String loanTerm;
  final String? estimatedRate;
  final String? estimatedMonthlyPayment;
  final String status;
  final int progressPercent;
  final String? submittedAt;
  final String? createdAt;

  MyLoanModel({
    required this.id,
    required this.applicationNumber,
    required this.loanType,
    this.iconImageUrl,
    required this.loanAmount,
    required this.loanTerm,
    this.estimatedRate,
    this.estimatedMonthlyPayment,
    required this.status,
    required this.progressPercent,
    this.submittedAt,
    this.createdAt,
  });

  factory MyLoanModel.fromJson(Map<String, dynamic> json) {
    return MyLoanModel(
      id: json['id'] ?? '',
      applicationNumber: json['applicationNumber'] ?? '',
      loanType: json['loanType'] ?? '',
      iconImageUrl: json['iconImageUrl'],
      loanAmount: json['loanAmount'] ?? '0',
      loanTerm: json['loanTerm'] ?? '',
      estimatedRate: json['estimatedRate'],
      estimatedMonthlyPayment: json['estimatedMonthlyPayment'],
      status: json['status'] ?? '',
      progressPercent: json['progressPercent'] ?? 0,
      submittedAt: json['submittedAt'],
      createdAt: json['createdAt'],
    );
  }
}
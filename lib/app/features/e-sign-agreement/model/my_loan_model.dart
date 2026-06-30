class MyLoanModel {
  final String id;
  final String applicationNumber;
  final String loanType;
  final String iconImageUrl;
  final String loanAmount;
  final String loanTerm;
  final String estimatedRate;
  final String estimatedMonthlyPayment;
  final String status;
  final int progressPercent;
  final String submittedAt;
  final String createdAt;

  MyLoanModel({
    required this.id,
    required this.applicationNumber,
    required this.loanType,
    required this.iconImageUrl,
    required this.loanAmount,
    required this.loanTerm,
    required this.estimatedRate,
    required this.estimatedMonthlyPayment,
    required this.status,
    required this.progressPercent,
    required this.submittedAt,
    required this.createdAt,
  });

  factory MyLoanModel.fromJson(Map<String, dynamic> json) {
    return MyLoanModel(
      id: json['id'] ?? '',
      applicationNumber: json['applicationNumber'] ?? '',
      loanType: json['loanType'] ?? '',
      iconImageUrl: json['iconImageUrl'] ?? '',
      loanAmount: json['loanAmount'] ?? '',
      loanTerm: json['loanTerm'] ?? '',
      estimatedRate: json['estimatedRate'] ?? '',
      estimatedMonthlyPayment: json['estimatedMonthlyPayment'] ?? '',
      status: json['status'] ?? '',
      progressPercent: json['progressPercent'] ?? 0,
      submittedAt: json['submittedAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}

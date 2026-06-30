class AgreementDetailsModel {
  final String id;
  final String status;
  final String statusLabel;
  final BorrowerModel? borrower;
  final LenderModel? lender;
  final LoanSummaryModel? loanSummary;
  final ApplicationModel? application;
  final List<AgreementSectionModel> sections;

  AgreementDetailsModel({
    required this.id,
    required this.status,
    required this.statusLabel,
    this.borrower,
    this.lender,
    this.loanSummary,
    this.application,
    required this.sections,
  });

  factory AgreementDetailsModel.fromJson(Map<String, dynamic> json) {
    return AgreementDetailsModel(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      statusLabel: json['statusLabel'] ?? '',
      borrower: json['borrower'] != null
          ? BorrowerModel.fromJson(json['borrower'])
          : null,
      lender: json['lender'] != null
          ? LenderModel.fromJson(json['lender'])
          : null,
      loanSummary: json['loanSummary'] != null
          ? LoanSummaryModel.fromJson(json['loanSummary'])
          : null,
      application: json['application'] != null
          ? ApplicationModel.fromJson(json['application'])
          : null,
      sections: json['sections'] != null
          ? (json['sections'] as List)
              .map((i) => AgreementSectionModel.fromJson(i))
              .toList()
          : [],
    );
  }
}

class BorrowerModel {
  final String id;
  final String name;
  final String email;

  BorrowerModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory BorrowerModel.fromJson(Map<String, dynamic> json) {
    return BorrowerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class LenderModel {
  final String name;

  LenderModel({
    required this.name,
  });

  factory LenderModel.fromJson(Map<String, dynamic> json) {
    return LenderModel(
      name: json['name'] ?? '',
    );
  }
}

class AgreementSectionModel {
  final String id;
  final int order;
  final String title;
  final String description;
  final bool isOpen;

  AgreementSectionModel({
    required this.id,
    required this.order,
    required this.title,
    required this.description,
    required this.isOpen,
  });

  factory AgreementSectionModel.fromJson(Map<String, dynamic> json) {
    return AgreementSectionModel(
      id: json['id'] ?? '',
      order: json['order'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isOpen: json['isOpen'] ?? false,
    );
  }
}

class LoanSummaryModel {
  final String loanAmount;
  final String loanAmountDisplay;
  final String loanTerm;
  final String interestRate;
  final String monthlyPayment;
  final String monthlyPaymentDisplay;
  final String applicationNumber;
  final String loanType;
  final String status;

  LoanSummaryModel({
    required this.loanAmount,
    required this.loanAmountDisplay,
    required this.loanTerm,
    required this.interestRate,
    required this.monthlyPayment,
    required this.monthlyPaymentDisplay,
    required this.applicationNumber,
    required this.loanType,
    required this.status,
  });

  factory LoanSummaryModel.fromJson(Map<String, dynamic> json) {
    return LoanSummaryModel(
      loanAmount: json['loanAmount'] ?? '',
      loanAmountDisplay: json['loanAmountDisplay'] ?? '',
      loanTerm: json['loanTerm'] ?? '',
      interestRate: json['interestRate'] ?? '',
      monthlyPayment: json['monthlyPayment'] ?? '',
      monthlyPaymentDisplay: json['monthlyPaymentDisplay'] ?? '',
      applicationNumber: json['applicationNumber'] ?? '',
      loanType: json['loanType'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class ApplicationModel {
  final String id;
  final String applicationNumber;
  final String loanType;
  final String status;

  ApplicationModel({
    required this.id,
    required this.applicationNumber,
    required this.loanType,
    required this.status,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      id: json['id'] ?? '',
      applicationNumber: json['applicationNumber'] ?? '',
      loanType: json['loanType'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

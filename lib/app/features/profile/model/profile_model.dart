class ProfileModel {
  final String id;
  final String fullName;
  final String emailAddress;
  final String? phoneNumber;
  final String? profileImage;
  final String? profileImagePath;
  final String? profileImageUrl;
  final String? department;
  final String? location;
  final String role;
  final String roleLabel;
  final bool isEmailVerified;
  final bool isActive;
  final ProfileHeader? header;

  ProfileModel({
    required this.id,
    required this.fullName,
    required this.emailAddress,
    this.phoneNumber,
    this.profileImage,
    this.profileImagePath,
    this.profileImageUrl,
    this.department,
    this.location,
    required this.role,
    required this.roleLabel,
    required this.isEmailVerified,
    required this.isActive,
    this.header,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      emailAddress: json['email_address'] ?? '',
      phoneNumber: json['phone_number'],
      profileImage: json['profile_image'],
      profileImagePath: json['profile_image_path'],
      profileImageUrl: json['profile_image_url'],
      department: json['department'],
      location: json['location'],
      role: json['role'] ?? '',
      roleLabel: json['role_label'] ?? '',
      isEmailVerified: json['is_email_verified'] ?? false,
      isActive: json['is_active'] ?? false,
      header: json['header'] != null ? ProfileHeader.fromJson(json['header']) : null,
    );
  }
}

class ProfileHeader {
  final String? initials;
  final String? fullName;
  final String? emailAddress;
  final String? department;
  final String? location;
  final String? roleLabel;
  final String? status;
  final String? profileImage;
  final String? profileImagePath;

  ProfileHeader({
    this.initials,
    this.fullName,
    this.emailAddress,
    this.department,
    this.location,
    this.roleLabel,
    this.status,
    this.profileImage,
    this.profileImagePath,
  });

  factory ProfileHeader.fromJson(Map<String, dynamic> json) {
    return ProfileHeader(
      initials: json['initials'],
      fullName: json['full_name'],
      emailAddress: json['email_address'],
      department: json['department'],
      location: json['location'],
      roleLabel: json['role_label'],
      status: json['status'],
      profileImage: json['profile_image'],
      profileImagePath: json['profile_image_path'],
    );
  }
}
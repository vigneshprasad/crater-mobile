import 'package:hive/hive.dart';

class User extends HiveObject {
  final String token;

  final String pk;

  final String photo;

  final String email;

  final bool emailVerified;

  final String name;

  final int city;

  final String reason;

  final String phoneNumber;

  final bool phoneNumberVerified;

  final String role;

  final bool hasProfile;

  final bool hasBankDetails;

  final bool hasServices;

  final bool hasActiveSubscription;

  final String activeSubscriptionMembership;

  final dynamic panCard;

  final dynamic panCardSize;

  final int unreadNotifications;

  final bool isApproved;

  final List<int> objectives;

  final String linkedinUrl;

  final String intent;

  User({
    this.token,
    this.pk,
    this.photo,
    this.email,
    this.emailVerified,
    this.name,
    this.city,
    this.reason,
    this.phoneNumber,
    this.phoneNumberVerified,
    this.role,
    this.hasProfile,
    this.hasBankDetails,
    this.hasServices,
    this.hasActiveSubscription,
    this.activeSubscriptionMembership,
    this.panCard,
    this.panCardSize,
    this.unreadNotifications,
    this.isApproved,
    this.objectives,
    this.linkedinUrl,
    this.intent,
  });

  User copyWith({
    String token,
    String pk,
    String photo,
    String email,
    bool emailVerified,
    String name,
    int city,
    String reason,
    String phoneNumber,
    bool phoneNumberVerified,
    String role,
    bool hasProfile,
    bool hasBankDetails,
    bool hasServices,
    bool hasActiveSubscription,
    String activeSubscriptionMembership,
    dynamic panCard,
    dynamic panCardSize,
    int unreadNotifications,
    bool isApproved,
    List<int> objectives,
    String linkedinUrl,
    String intent,
    // int educationLevel,
    // int yearsOfExperience,
    // int companyType,
    // int sector,
  }) {
    return User(
      token: token ?? this.token,
      pk: pk ?? this.pk,
      photo: photo ?? this.photo,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      name: name ?? this.name,
      city: city ?? this.city,
      reason: reason ?? this.reason,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberVerified: phoneNumberVerified ?? this.phoneNumberVerified,
      role: role ?? this.role,
      hasProfile: hasProfile ?? this.hasProfile,
      hasBankDetails: hasBankDetails ?? this.hasBankDetails,
      hasServices: hasServices ?? this.hasServices,
      hasActiveSubscription:
          hasActiveSubscription ?? this.hasActiveSubscription,
      activeSubscriptionMembership:
          activeSubscriptionMembership ?? this.activeSubscriptionMembership,
      panCard: panCard ?? this.panCard,
      panCardSize: panCardSize ?? this.panCardSize,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      isApproved: isApproved ?? this.isApproved,
      objectives: objectives ?? this.objectives,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      intent: intent ?? this.intent,
      // educationLevel: educationLevel ?? this.educationLevel,
      // yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      // companyType: companyType ?? this.companyType,
      // sector: sector ?? this.sector,
    );
  }
}

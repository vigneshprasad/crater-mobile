import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/user_entity.dart';

part 'user_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.user)
@JsonSerializable()
class UserModel extends User {
  @HiveField(0)
  final String token;

  @HiveField(1)
  final String pk;

  @HiveField(2)
  final String photo;

  @HiveField(3)
  final String email;

  @HiveField(4)
  @JsonKey(name: 'email_verified')
  final bool emailVerified;

  @HiveField(5)
  final String name;

  @HiveField(6)
  final int city;

  @HiveField(7)
  final String reason;

  @HiveField(8)
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  @HiveField(9)
  @JsonKey(name: 'phone_number_verified')
  final bool phoneNumberVerified;

  @HiveField(10)
  final String role;

  @HiveField(11)
  @JsonKey(name: 'has_profile')
  final bool hasProfile;

  @HiveField(12)
  @JsonKey(name: 'has_bank_details')
  final bool hasBankDetails;

  @HiveField(13)
  @JsonKey(name: 'has_services')
  final bool hasServices;

  @HiveField(14)
  @JsonKey(name: 'has_active_subscription')
  final bool hasActiveSubscription;

  @HiveField(15)
  @JsonKey(name: 'active_subscription_membership')
  final String activeSubscriptionMembership;

  @HiveField(16)
  @JsonKey(name: 'pan_card')
  final dynamic panCard;

  @HiveField(17)
  @JsonKey(name: 'pan_card_size')
  final dynamic panCardSize;

  @HiveField(18)
  @JsonKey(name: 'unread_notifications')
  final int unreadNotifications;

  @HiveField(19)
  @JsonKey(name: 'is_approved')
  final bool isApproved;

  @HiveField(20)
  final List<int> objectives;

  @HiveField(21)
  @JsonKey(name: "linkedin_url")
  String linkedinUrl;

  @HiveField(22)
  String intent;

  UserModel({
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
  }) : super(
          token: token,
          pk: pk,
          photo: photo,
          email: email,
          emailVerified: emailVerified,
          name: name,
          city: city,
          reason: reason,
          phoneNumber: phoneNumber,
          phoneNumberVerified: phoneNumberVerified,
          role: role,
          hasProfile: hasProfile,
          hasBankDetails: hasBankDetails,
          hasServices: hasServices,
          hasActiveSubscription: hasActiveSubscription,
          activeSubscriptionMembership: activeSubscriptionMembership,
          panCard: panCard,
          panCardSize: panCardSize,
          unreadNotifications: unreadNotifications,
          isApproved: isApproved,
          objectives: objectives,
          linkedinUrl: linkedinUrl,
          intent: intent,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
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
  }) {
    return UserModel(
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
    );
  }
}

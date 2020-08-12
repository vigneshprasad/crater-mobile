import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class User extends HiveObject {
  @HiveField(0)
  final String pk;

  @HiveField(1)
  final String photo;

  @HiveField(2)
  final String email;

  @HiveField(3)
  @JsonKey(name: 'email_verified')
  final bool emailVerified;

  @HiveField(4)
  final String name;

  @HiveField(5)
  final int city;

  @HiveField(6)
  final String reason;

  @HiveField(7)
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  @HiveField(8)
  @JsonKey(name: 'phone_number_verified')
  final bool phoneNumberVerified;

  @HiveField(9)
  final String role;

  @HiveField(10)
  @JsonKey(name: 'has_profile')
  final bool hasProfile;

  @HiveField(11)
  @JsonKey(name: 'has_bank_details')
  final bool hasBankDetails;

  @HiveField(12)
  @JsonKey(name: 'has_services')
  final bool hasServices;

  @HiveField(13)
  @JsonKey(name: 'has_active_subscription')
  final bool hasActiveSubscription;

  @HiveField(14)
  @JsonKey(name: 'active_subscription_membership')
  final String activeSubscriptionMembership;

  @HiveField(15)
  @JsonKey(name: 'pan_card')
  final dynamic panCard;

  @HiveField(16)
  @JsonKey(name: 'pan_card_size')
  final dynamic panCardSize;

  @HiveField(17)
  @JsonKey(name: 'unread_notifications')
  final int unreadNotifications;

  @HiveField(18)
  @JsonKey(name: 'is_approved')
  final bool isApproved;

  User({
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
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

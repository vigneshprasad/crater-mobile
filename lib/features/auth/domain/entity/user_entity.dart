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
  });
}

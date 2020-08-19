import 'package:equatable/equatable.dart';

class User extends Equatable {
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

  const User({
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

  @override
  List<Object> get props => [
        token,
        pk,
        photo,
        email,
        emailVerified,
        name,
        city,
        reason,
        phoneNumber,
        phoneNumberVerified,
        role,
        hasProfile,
        hasBankDetails,
        hasServices,
        hasActiveSubscription,
        activeSubscriptionMembership,
        panCard,
        panCardSize,
        unreadNotifications,
        isApproved,
      ];
}

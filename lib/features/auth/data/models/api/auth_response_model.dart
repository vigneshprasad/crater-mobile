import 'package:json_annotation/json_annotation.dart';

import '../user_model.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  final String? token;
  final UserModel? user;

  AuthResponseModel({
    this.token,
    this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  UserModel toUserModel() => UserModel(
        token: token,
        pk: user?.pk,
        photo: user?.photo,
        email: user?.email,
        emailVerified: user?.emailVerified,
        name: user?.name,
        city: user?.city,
        reason: user?.reason,
        phoneNumber: user?.phoneNumber,
        phoneNumberVerified: user?.phoneNumberVerified,
        role: user?.role,
        hasProfile: user?.hasProfile,
        hasBankDetails: user?.hasBankDetails,
        hasServices: user?.hasServices,
        hasActiveSubscription: user?.hasActiveSubscription,
        activeSubscriptionMembership: user?.activeSubscriptionMembership,
        panCard: user?.panCard,
        panCardSize: user?.panCardSize,
        unreadNotifications: user?.unreadNotifications,
        isApproved: user?.isApproved,
        objectives: user?.objectives,
        linkedinUrl: user?.linkedinUrl,
        intent: user?.intent,
      );
}

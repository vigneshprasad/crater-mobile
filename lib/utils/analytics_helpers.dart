import '../features/auth/domain/entity/user_entity.dart';
import '../features/auth/domain/entity/user_profile_entity.dart';

Map<String, dynamic> getUserTraitsFromModel(User user) {
  return {
    "email": user.email,
    "email_verified": user.emailVerified,
    "intent": user.intent,
    "linkedin_url": user.linkedinUrl,
    "phone_number": user.phoneNumber,
    "phone_number_verified": user.phoneNumberVerified,
    "objectives": user.objectives,
    "is_approved": user.isApproved,
  };
}

Map<String, dynamic> getProfileTraitsFromModel(UserProfile profile) {
  return {
    "user_tags": profile.tagList?.map((e) => e.name).toList(),
    "role": profile.role,
    "has_introduction": profile.introduction?.isNotEmpty ?? false,
  };
}

import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';

Map<String, dynamic> getUserTraitsFromModel(User user) {
  return {
    "email": user.email,
    "email_verified": user.emailVerified,
    "intent": user.intent,
    "linkedin_url": user.linkedinUrl,
    "phone_number": user.phoneNumber,
    "phone_number_verified": user.phoneNumberVerified,
  };
}

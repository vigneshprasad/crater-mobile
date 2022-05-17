import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/auth/data/models/api/referrals_response_model.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';

import '../../../../core/error/failures.dart';
import '../entity/user_entity.dart';
import '../entity/user_profile_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginwithEmail(
      String email, String password, String osId);
  Future<Either<Failure, User>> registerwithEmail(
      String name, String email, String password, String osId);
  Future<Either<Failure, User>> authWithGoogle(String token, String osId);
  Future<Either<Failure, User>> authWithFacebook(String token, String osId);
  Future<Either<Failure, User>> authWithLinkedIn(String token, String osId);
  Future<Either<Failure, User>> authWithApple(String token, String osId);
  Future<Either<Failure, bool>> getAuthenticationState();
  Future<Either<Failure, User>> patchUser(User user);
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, UserProfile>> postUserProfile(
      Map<String, dynamic> body);
  Future<Either<Failure, UserProfile>> getUserProfile();
  Future<Either<Failure, String>> postPasswordReset(String email);
  Future<Either<Failure, String>> postNewPassword(Map<String, String> body);
  Future<Either<Failure, void>> sendOtp(String phone);
  Future<Either<Failure, User>> verifyOtp(String phone, String otp);
  Future<Either<Failure, UserPermission>> getUserPermission();
  Future<Either<Failure, ReferralsResponse>> getReferrals(
      int? page, int? pageSize);
}

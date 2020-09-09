// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      token: fields[0] as String,
      pk: fields[1] as String,
      photo: fields[2] as String,
      email: fields[3] as String,
      emailVerified: fields[4] as bool,
      name: fields[5] as String,
      city: fields[6] as int,
      reason: fields[7] as String,
      phoneNumber: fields[8] as String,
      phoneNumberVerified: fields[9] as bool,
      role: fields[10] as String,
      hasProfile: fields[11] as bool,
      hasBankDetails: fields[12] as bool,
      hasServices: fields[13] as bool,
      hasActiveSubscription: fields[14] as bool,
      activeSubscriptionMembership: fields[15] as String,
      panCard: fields[16] as dynamic,
      panCardSize: fields[17] as dynamic,
      unreadNotifications: fields[18] as int,
      isApproved: fields[19] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.pk)
      ..writeByte(2)
      ..write(obj.photo)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.emailVerified)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.city)
      ..writeByte(7)
      ..write(obj.reason)
      ..writeByte(8)
      ..write(obj.phoneNumber)
      ..writeByte(9)
      ..write(obj.phoneNumberVerified)
      ..writeByte(10)
      ..write(obj.role)
      ..writeByte(11)
      ..write(obj.hasProfile)
      ..writeByte(12)
      ..write(obj.hasBankDetails)
      ..writeByte(13)
      ..write(obj.hasServices)
      ..writeByte(14)
      ..write(obj.hasActiveSubscription)
      ..writeByte(15)
      ..write(obj.activeSubscriptionMembership)
      ..writeByte(16)
      ..write(obj.panCard)
      ..writeByte(17)
      ..write(obj.panCardSize)
      ..writeByte(18)
      ..write(obj.unreadNotifications)
      ..writeByte(19)
      ..write(obj.isApproved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    token: json['token'] as String,
    pk: json['pk'] as String,
    photo: json['photo'] as String,
    email: json['email'] as String,
    emailVerified: json['email_verified'] as bool,
    name: json['name'] as String,
    city: json['city'] as int,
    reason: json['reason'] as String,
    phoneNumber: json['phone_number'] as String,
    phoneNumberVerified: json['phone_number_verified'] as bool,
    role: json['role'] as String,
    hasProfile: json['has_profile'] as bool,
    hasBankDetails: json['has_bank_details'] as bool,
    hasServices: json['has_services'] as bool,
    hasActiveSubscription: json['has_active_subscription'] as bool,
    activeSubscriptionMembership:
        json['active_subscription_membership'] as String,
    panCard: json['pan_card'],
    panCardSize: json['pan_card_size'],
    unreadNotifications: json['unread_notifications'] as int,
    isApproved: json['is_approved'] as bool,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'token': instance.token,
      'pk': instance.pk,
      'photo': instance.photo,
      'email': instance.email,
      'email_verified': instance.emailVerified,
      'name': instance.name,
      'city': instance.city,
      'reason': instance.reason,
      'phone_number': instance.phoneNumber,
      'phone_number_verified': instance.phoneNumberVerified,
      'role': instance.role,
      'has_profile': instance.hasProfile,
      'has_bank_details': instance.hasBankDetails,
      'has_services': instance.hasServices,
      'has_active_subscription': instance.hasActiveSubscription,
      'active_subscription_membership': instance.activeSubscriptionMembership,
      'pan_card': instance.panCard,
      'pan_card_size': instance.panCardSize,
      'unread_notifications': instance.unreadNotifications,
      'is_approved': instance.isApproved,
    };

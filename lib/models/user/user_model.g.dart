// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      pk: fields[0] as String,
      photo: fields[1] as String,
      email: fields[2] as String,
      emailVerified: fields[3] as bool,
      name: fields[4] as String,
      city: fields[5] as int,
      reason: fields[6] as String,
      phoneNumber: fields[7] as String,
      phoneNumberVerified: fields[8] as bool,
      role: fields[9] as String,
      hasProfile: fields[10] as bool,
      hasBankDetails: fields[11] as bool,
      hasServices: fields[12] as bool,
      hasActiveSubscription: fields[13] as bool,
      activeSubscriptionMembership: fields[14] as String,
      panCard: fields[15] as dynamic,
      panCardSize: fields[16] as dynamic,
      unreadNotifications: fields[17] as int,
      isApproved: fields[18] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.photo)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.emailVerified)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.city)
      ..writeByte(6)
      ..write(obj.reason)
      ..writeByte(7)
      ..write(obj.phoneNumber)
      ..writeByte(8)
      ..write(obj.phoneNumberVerified)
      ..writeByte(9)
      ..write(obj.role)
      ..writeByte(10)
      ..write(obj.hasProfile)
      ..writeByte(11)
      ..write(obj.hasBankDetails)
      ..writeByte(12)
      ..write(obj.hasServices)
      ..writeByte(13)
      ..write(obj.hasActiveSubscription)
      ..writeByte(14)
      ..write(obj.activeSubscriptionMembership)
      ..writeByte(15)
      ..write(obj.panCard)
      ..writeByte(16)
      ..write(obj.panCardSize)
      ..writeByte(17)
      ..write(obj.unreadNotifications)
      ..writeByte(18)
      ..write(obj.isApproved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
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

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
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

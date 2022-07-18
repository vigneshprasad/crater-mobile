// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referrals_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferralsResponse _$ReferralsResponseFromJson(Map<String, dynamic> json) =>
    ReferralsResponse(
      count: json['count'] as int?,
      currentPage: json['current_page'] as int?,
      next: json['next'] as String?,
      pages: json['pages'] as int?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Referral.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReferralsResponseToJson(ReferralsResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'current_page': instance.currentPage,
      'next': instance.next,
      'pages': instance.pages,
      'previous': instance.previous,
      'results': instance.results,
    };

Referral _$ReferralFromJson(Map<String, dynamic> json) => Referral(
      id: json['id'] as int?,
      amount: json['amount'] as int?,
      user: json['user'] as String?,
      referrer: json['referrer'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ReferralToJson(Referral instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'user': instance.user,
      'referrer': instance.referrer,
      'status': instance.status,
    };

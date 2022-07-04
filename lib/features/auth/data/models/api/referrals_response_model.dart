import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'referrals_response_model.g.dart';

@JsonSerializable()
class ReferralsResponse extends Equatable {
  final int? count;

  @JsonKey(name: "current_page")
  final int? currentPage;

  final String? next;

  final int? pages;

  final String? previous;

  final List<Referral>? results;

  const ReferralsResponse({
    this.count,
    this.currentPage,
    this.next,
    this.pages,
    this.previous,
    this.results,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [];
    if (count != null) temp.add(count!);
    if (currentPage != null) temp.add(currentPage!);
    if (next != null) temp.add(next!);
    if (pages != null) temp.add(pages!);
    if (previous != null) temp.add(previous!);
    if (results != null) temp.add(results!);
    return temp;
  }

  factory ReferralsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReferralsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReferralsResponseToJson(this);
}

@JsonSerializable()
class Referral extends Equatable {
  final int? id;
  final int? amount;
  final String? user;
  final String? referrer;
  final String? status;

  const Referral({
    this.id,
    this.amount,
    this.user,
    this.referrer,
    this.status,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [];
    if (id != null) temp.add(id!);
    if (amount != null) temp.add(amount!);
    if (user != null) temp.add(user!);
    if (referrer != null) temp.add(referrer!);
    if (status != null) temp.add(status!);
    return temp;
  }

  factory Referral.fromJson(Map<String, dynamic> json) =>
      _$ReferralFromJson(json);
  Map<String, dynamic> toJson() => _$ReferralToJson(this);
}

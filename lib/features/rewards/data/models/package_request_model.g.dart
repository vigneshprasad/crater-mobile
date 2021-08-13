// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageRequestModel _$PackageRequestModelFromJson(Map<String, dynamic> json) {
  return PackageRequestModel(
    quantity: json['quantity'] as int?,
    requestedBy: json['requestedBy'] as String?,
    package: json['package'] as int?,
    pointsApplied: json['pointsApplied'] as int?,
    status: _$enumDecodeNullable(_$PackageRequestStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$PackageRequestModelToJson(
        PackageRequestModel instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'requestedBy': instance.requestedBy,
      'package': instance.package,
      'pointsApplied': instance.pointsApplied,
      'status': _$PackageRequestStatusEnumMap[instance.status],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$PackageRequestStatusEnumMap = {
  PackageRequestStatus.requested: 'requested',
  PackageRequestStatus.inProgress: 'in_progress',
  PackageRequestStatus.rejected: 'rejected',
  PackageRequestStatus.completed: 'completed',
};

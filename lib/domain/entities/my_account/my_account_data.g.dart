// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyAccountData _$MyAccountDataFromJson(Map<String, dynamic> json) =>
    MyAccountData(
      exception: json['exception'] as String?,
      original: json['original'] == null
          ? null
          : OriginalData.fromJson(json['original'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyAccountDataToJson(MyAccountData instance) =>
    <String, dynamic>{
      'original': instance.original,
      'exception': instance.exception,
    };

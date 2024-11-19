// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsData _$DocumentsDataFromJson(Map<String, dynamic> json) =>
    DocumentsData(
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => Documents.fromJson(e as Map<String, dynamic>))
          .toList(),
      receipts: json['receipts'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DocumentsDataToJson(DocumentsData instance) =>
    <String, dynamic>{
      'documents': instance.documents,
      'receipts': instance.receipts,
    };

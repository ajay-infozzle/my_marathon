// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Documents _$DocumentsFromJson(Map<String, dynamic> json) => Documents(
      salesCheckId: json['SalesCheckId'] as String?,
      checkListId: json['CheckListId'] as String?,
      checkListName: json['CheckListName'] as String?,
      category: json['Category'] as String?,
      categoryType: json['CategoryType'] as String?,
      categoryId: json['CategoryId'] as String?,
      completed: json['Completed'] as String?,
      fileName: json['FileName'] as String?,
      filePath: json['FilePath'] as String?,
      remarks: json['Remarks'] as String?,
      date: json['Date'] as String?,
      downloadLink: json['download_link'] as String?,
    );

Map<String, dynamic> _$DocumentsToJson(Documents instance) => <String, dynamic>{
      'SalesCheckId': instance.salesCheckId,
      'CheckListId': instance.checkListId,
      'CheckListName': instance.checkListName,
      'Category': instance.category,
      'CategoryType': instance.categoryType,
      'CategoryId': instance.categoryId,
      'Completed': instance.completed,
      'FileName': instance.fileName,
      'FilePath': instance.filePath,
      'Remarks': instance.remarks,
      'Date': instance.date,
      'download_link': instance.downloadLink,
    };

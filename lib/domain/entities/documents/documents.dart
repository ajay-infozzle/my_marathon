import 'package:json_annotation/json_annotation.dart';

part 'documents.g.dart';

@JsonSerializable()
class Documents {
  @JsonKey(name: 'SalesCheckId')
  String? salesCheckId;
  @JsonKey(name: 'CheckListId')
  String? checkListId;
  @JsonKey(name: 'CheckListName')
  String? checkListName;
  @JsonKey(name: 'Category')
  String? category;
  @JsonKey(name: 'CategoryType')
  String? categoryType;
  @JsonKey(name: 'CategoryId')
  String? categoryId;
  @JsonKey(name: 'Completed')
  String? completed;
  @JsonKey(name: 'FileName')
  String? fileName;
  @JsonKey(name: 'FilePath')
  String? filePath;
  @JsonKey(name: 'Remarks')
  String? remarks;
  @JsonKey(name: 'Date')
  String? date;
  @JsonKey(name: 'download_link')
  String? downloadLink;


  Documents({
      this.salesCheckId,
      this.checkListId,
      this.checkListName,
      this.category,
      this.categoryType,
      this.categoryId,
      this.completed,
      this.fileName,
      this.filePath,
      this.remarks,
      this.date,
      this.downloadLink});

  Map<String, dynamic> toJson() => _$DocumentsToJson(this);

  factory Documents.fromJson(Map<String, dynamic> json) =>
      _$DocumentsFromJson(json);

  @override
  String toString() => toJson().toString();
}

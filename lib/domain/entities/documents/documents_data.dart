import 'package:json_annotation/json_annotation.dart';
import 'package:marathon/domain/entities/documents/documents.dart';

part 'documents_data.g.dart';
@JsonSerializable()
class DocumentsData {

  List<Documents>? documents;
  Map? receipts;

  DocumentsData({this.documents,this.receipts});

  Map<String, dynamic> toJson() => _$DocumentsDataToJson(this);

  factory DocumentsData.fromJson(Map<String, dynamic> json) =>
      _$DocumentsDataFromJson(json);

  @override
  String toString() => toJson().toString();
}
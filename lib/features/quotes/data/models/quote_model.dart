import 'package:json_annotation/json_annotation.dart';

part 'quote_model.g.dart';

@JsonSerializable()
class QuoteModel {
  @JsonKey(name: 'q')
  final String content;

  @JsonKey(name: 'a')
  final String author;

  QuoteModel({required this.content, required this.author});

  factory QuoteModel.fromJson(Map<String, dynamic> json) => _$QuoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuoteModel &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          author == other.author;

  @override
  int get hashCode => content.hashCode ^ author.hashCode;
}

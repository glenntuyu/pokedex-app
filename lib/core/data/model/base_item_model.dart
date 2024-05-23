import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_item_model.g.dart';

@JsonSerializable()
class BaseItemModel extends Equatable {
  const BaseItemModel({
    required this.name,
    required this.url,
  });
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'url')
  final String? url;

  factory BaseItemModel.fromJson(Map<String, dynamic> json) =>
      _$BaseItemModelFromJson(json);

  @override
  List<Object?> get props => [
        name,
        url,
      ];
}
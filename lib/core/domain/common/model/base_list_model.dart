import 'package:equatable/equatable.dart';

class BaseListModel<T> extends Equatable {
  final int? count;
  final String? next;
  final String? previous;
  final List<T> results;

  const BaseListModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BaseListModel.fromJson(Map<String, dynamic> json, Function fromJsonT) {
    return BaseListModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>?)
              ?.map<T>((post) => fromJsonT(post))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson(List<dynamic> post) {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results,
    };
  }

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        results,
      ];
}

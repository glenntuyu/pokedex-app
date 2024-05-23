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

  @override
  List<Object?> get props => [
        name,
        url,
      ];
}

const dummyPokemons = [
  BaseItemModel(
    name: 'Bulbasaur',
    url : 'https://pokeapi.co/api/v2/pokemon/1/',
  ),
  BaseItemModel(
    name: 'ivysaur',
    url : 'https://pokeapi.co/api/v2/pokemon/2/',
  ),
  BaseItemModel(
    name: 'venusaur',
    url : 'https://pokeapi.co/api/v2/pokemon/3/',
  ),
  BaseItemModel(
    name: 'charmander',
    url : 'https://pokeapi.co/api/v2/pokemon/4/',
  ),
  BaseItemModel(
    name: 'charmeleon',
    url : 'https://pokeapi.co/api/v2/pokemon/5/',
  ),
  BaseItemModel(
    name: 'charizard',
    url : 'https://pokeapi.co/api/v2/pokemon/6/',
  ),
  BaseItemModel(
    name: 'squirtle',
    url : 'https://pokeapi.co/api/v2/pokemon/7/',
  ),
  BaseItemModel(
    name: 'wartortle',
    url : 'https://pokeapi.co/api/v2/pokemon/8/',
  ),
  BaseItemModel(
    name: 'blastoise',
    url : 'https://pokeapi.co/api/v2/pokemon/9/',
  ),
  BaseItemModel(
    name: 'caterpie',
    url : 'https://pokeapi.co/api/v2/pokemon/10/',
  ),
];
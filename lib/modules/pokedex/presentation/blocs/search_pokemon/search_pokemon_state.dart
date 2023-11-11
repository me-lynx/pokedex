import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';
import 'package:tuple/tuple.dart';

abstract class SearchPokemonState {}

class SearchLoading extends SearchPokemonState {}

class SearchSuccess extends SearchPokemonState {
  final List<Tuple2<Pokemon, int>> pokemons;

  SearchSuccess(this.pokemons);
}

class SearchFailure extends SearchPokemonState {}

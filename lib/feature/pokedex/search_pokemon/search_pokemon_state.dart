import 'package:pokedex/feature/models/pokemon.dart';

abstract class SearchPokemonState {}

class SearchLoading extends SearchPokemonState {}

class SearchSuccess extends SearchPokemonState {
  final List<Pokemon> pokemons;

  SearchSuccess(this.pokemons);
}

class SearchFailure extends SearchPokemonState {}

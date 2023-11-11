import 'package:pokedex/feature/models/pokemon.dart';
import 'package:pokedex/feature/models/pokemon_result.dart';

abstract class PokemonInfoState {}

class PokemonInfoLoading extends PokemonInfoState {}

class PokemonInfoLoaded extends PokemonInfoState {
  Pokemon pokemon;

  PokemonInfoLoaded(this.pokemon);
}

class PokemonInfoError extends PokemonInfoState {
  final String message;

  PokemonInfoError(this.message);
}

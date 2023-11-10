import 'package:pokedex/feature/models/pokemon_model.dart';

abstract class PokemonInfoState {}

class PokemonInfoLoading extends PokemonInfoState {}

class PokemonInfoLoaded extends PokemonInfoState {
  Future<Pokemon> pokemon;

  PokemonInfoLoaded(this.pokemon);
}

class PokemonInfoError extends PokemonInfoState {
  final String message;

  PokemonInfoError(this.message);
}

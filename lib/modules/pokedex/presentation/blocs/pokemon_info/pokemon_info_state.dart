import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';

abstract class PokemonInfoState {}

class PokemonInfoLoading extends PokemonInfoState {
  List<Object> get props => [];
}

class PokemonInfoLoaded extends PokemonInfoState {
  Pokemon pokemon;

  PokemonInfoLoaded(this.pokemon);
}

class PokemonInfoError extends PokemonInfoState {
  final String message;

  PokemonInfoError(this.message);
}

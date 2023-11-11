import 'package:equatable/equatable.dart';
import 'package:pokedex/feature/models/pokemon.dart';
import 'package:pokedex/feature/models/pokemon_result.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();
}

class PokemonInitial extends PokemonState {
  @override
  List<Object> get props => [];
}

class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;

  const PokemonLoaded(this.pokemons);

  @override
  List<Object> get props => [pokemons];
}

class PokemonError extends PokemonState {
  final String message;

  const PokemonError(this.message);

  @override
  List<Object> get props => [message];
}

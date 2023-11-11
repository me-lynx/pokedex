import 'package:equatable/equatable.dart';
import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';
import 'package:tuple/tuple.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();
}

class PokemonInitial extends PokemonState {
  @override
  List<Object> get props => [];
}

class PokemonLoaded extends PokemonState {
  final List<Tuple2<Pokemon, int>> pokemons;

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

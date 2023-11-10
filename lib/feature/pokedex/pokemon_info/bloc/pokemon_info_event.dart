import 'package:pokedex/feature/models/pokemon_model.dart';

abstract class PokemonInfoEvent {}

class LoadPokemonInfo extends PokemonInfoEvent {
  final Pokemon pokemonName;

  LoadPokemonInfo(this.pokemonName);
}

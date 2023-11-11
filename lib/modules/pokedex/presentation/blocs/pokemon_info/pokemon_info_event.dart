abstract class PokemonInfoEvent {}

class LoadPokemonInfo extends PokemonInfoEvent {
  final String pokemonName;

  LoadPokemonInfo(this.pokemonName);
}

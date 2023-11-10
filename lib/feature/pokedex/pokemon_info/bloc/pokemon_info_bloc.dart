import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_event.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_state.dart';

import 'package:pokedex/feature/models/pokemon_model.dart';
import 'package:pokedex/feature/pokedex/pokemon_repository.dart';

class PokemonInfoBloc extends Bloc<PokemonInfoEvent, PokemonInfoState> {
  final PokemonRepository pokemonRepository;
  final Pokemon pokemon;

  PokemonInfoBloc(this.pokemonRepository, this.pokemon)
      : super(PokemonInfoLoading()) {
    on<PokemonInfoEvent>((event, emit) async {
      try {
        Future<Pokemon> pokemons =
            pokemonRepository.getPokemonInfo(pokemon.name);
        emit(PokemonInfoLoaded(pokemons));
      } catch (e) {
        emit(PokemonInfoError(e.toString()));
      }
    });
  }
}

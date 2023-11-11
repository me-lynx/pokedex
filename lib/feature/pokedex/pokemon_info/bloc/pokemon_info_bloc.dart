import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/feature/models/pokemon.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_event.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_state.dart';

import 'package:pokedex/feature/pokedex/pokemon_repository.dart';

class PokemonInfoBloc extends Bloc<PokemonInfoEvent, PokemonInfoState> {
  final PokemonRepository pokemonRepository;

  PokemonInfoBloc(this.pokemonRepository) : super(PokemonInfoLoading()) {
    on<LoadPokemonInfo>(_onLoadPokemonInfo);
  }
  Future<void> _onLoadPokemonInfo(
      LoadPokemonInfo event, Emitter<PokemonInfoState> emit) async {
    emit(PokemonInfoLoading());
    try {
      late Pokemon? pokemonReturn;
      pokemonReturn =
          await pokemonRepository.getPokemonByName(event.pokemonName);
      if (pokemonReturn != null) {
        emit(PokemonInfoLoaded(pokemonReturn));
      } else {
        emit(PokemonInfoError(
            'No Pokemon found with name ${event.pokemonName}'));
      }
    } catch (e) {
      emit(PokemonInfoError(e.toString()));
    }
  }
}

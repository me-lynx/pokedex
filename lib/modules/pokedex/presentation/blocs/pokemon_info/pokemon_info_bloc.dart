import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon_info/pokemon_info_event.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon_info/pokemon_info_state.dart';
import 'package:pokedex/modules/pokedex/data/repositories/pokemon_repository.dart';
import 'package:pokedex/main.dart';

class PokemonInfoBloc extends Bloc<PokemonInfoEvent, PokemonInfoState> {
  final PokemonRepository pokemonRepository;

  PokemonInfoBloc()
      : pokemonRepository = getIt<PokemonRepository>(),
        super(PokemonInfoLoading()) {
    on<LoadPokemonInfo>(_onLoadPokemonInfo);
  }

  Future<void> _onLoadPokemonInfo(
      LoadPokemonInfo event, Emitter<PokemonInfoState> emit) async {
    emit(PokemonInfoLoading());
    try {
      late Pokemon? pokemonReturn;
      pokemonReturn =
          await pokemonRepository.getPokemonByName(event.pokemonName);

      emit(PokemonInfoLoaded(pokemonReturn));
    } catch (e) {
      emit(PokemonInfoError(e.toString()));
    }
  }
}

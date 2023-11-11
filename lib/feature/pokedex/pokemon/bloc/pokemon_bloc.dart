import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/feature/models/pokemon.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_event.dart';
import 'package:pokedex/feature/models/pokemon_result.dart';
import 'package:pokedex/feature/pokedex/pokemon_repository.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository pokemonRepository;
  List<Pokemon> pokemons = [];

  PokemonBloc(this.pokemonRepository) : super(PokemonInitial()) {
    on<FetchPokemons>((event, emit) async {
      try {
        pokemons = await pokemonRepository.fetchPokemons();
        emit(PokemonLoaded(pokemons));
      } catch (e) {
        emit(PokemonError(e.toString()));
      }
    });
  }
}

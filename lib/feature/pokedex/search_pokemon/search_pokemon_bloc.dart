import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/feature/models/pokemon.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_state.dart';
import 'package:pokedex/feature/pokedex/search_pokemon/search_pokemon_event.dart';
import 'package:pokedex/feature/pokedex/search_pokemon/search_pokemon_state.dart';

class SearchPokemonBloc extends Bloc<SearchPokemonEvent, SearchPokemonState> {
  final PokemonBloc pokemonBloc;
  StreamSubscription? pokemonSubscription;

  SearchPokemonBloc({required this.pokemonBloc})
      : super(pokemonBloc.state is PokemonLoaded
            ? SearchSuccess((pokemonBloc.state as PokemonLoaded).pokemons)
            : SearchLoading()) {
    pokemonSubscription = pokemonBloc.stream.listen((state) {
      if (state is PokemonLoaded) {
        add(SearchUpdated(''));
      }
    });
    on<SearchUpdated>(_onSearchUpdated);
  }

  Future<void> _onSearchUpdated(
      SearchUpdated event, Emitter<SearchPokemonState> emit) async {
    if (pokemonBloc.state is PokemonLoaded) {
      emit(SearchLoading());
      final List<Pokemon> pokemons =
          (pokemonBloc.state as PokemonLoaded).pokemons;
      final List<Pokemon> searchResults = pokemons
          .where((pokemon) => pokemon.name.contains(event.query))
          .toList();
      emit(SearchSuccess(searchResults));
    } else {
      emit(SearchFailure());
    }
  }

  @override
  Future<void> close() {
    pokemonSubscription?.cancel();
    return super.close();
  }
}

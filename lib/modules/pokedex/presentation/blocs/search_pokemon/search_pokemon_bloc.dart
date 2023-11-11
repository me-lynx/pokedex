import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon/pokemon_state.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/search_pokemon/search_pokemon_event.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/search_pokemon/search_pokemon_state.dart';
import 'package:tuple/tuple.dart';

class SearchPokemonBloc extends Bloc<SearchPokemonEvent, SearchPokemonState> {
  final PokemonBloc pokemonBloc;
  StreamSubscription? pokemonSubscription;

  SearchPokemonBloc({required this.pokemonBloc})
      : super(pokemonBloc.state is PokemonLoaded
            ? SearchSuccess((pokemonBloc.state as PokemonLoaded)
                .pokemons
                .cast<Tuple2<Pokemon, int>>())
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
    try {
      if (pokemonBloc.state is PokemonLoaded) {
        emit(SearchLoading());
        final List<Tuple2<Pokemon, int>> pokemons =
            (pokemonBloc.state as PokemonLoaded).pokemons;
        final List<Tuple2<Pokemon, int>> searchResults = pokemons
            .where((tuple) => tuple.item1.name.contains(event.query))
            .toList();
        emit(SearchSuccess(searchResults));
      } else {
        emit(SearchFailure());
      }
    } catch (e) {
      emit(SearchFailure());
    }
  }

  @override
  Future<void> close() {
    pokemonSubscription?.cancel();
    return super.close();
  }
}

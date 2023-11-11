import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon/pokemon_event.dart';
import 'package:pokedex/modules/pokedex/data/repositories/pokemon_repository.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon/pokemon_state.dart';
import 'package:tuple/tuple.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository pokemonRepository;
  List<Tuple2<Pokemon, int>> pokemons = [];

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

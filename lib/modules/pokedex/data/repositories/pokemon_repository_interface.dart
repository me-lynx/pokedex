import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';
import 'package:tuple/tuple.dart';

abstract class IPokemonRepository {
  Future<List<Tuple2<Pokemon, int>>> fetchPokemons();
  Future<Pokemon> getPokemonByName(String pokemonName);
}

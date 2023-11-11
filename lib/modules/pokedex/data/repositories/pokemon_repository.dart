import 'dart:convert';

import 'package:pokedex/modules/pokedex/core/constants/constants.dart';
import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';
import 'package:pokedex/modules/pokedex/data/models/pokemon_result.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class PokemonRepository {
  List<Pokemon> pokemons = [];
  final http.Client client;
  PokemonRepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<Tuple2<Pokemon, int>>> fetchPokemons() async {
    var response =
        await client.get(Uri.parse(Constants.pokedexApiUrlWithOffsetandLimit));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch pokemons: ${response.statusCode}');
    }

    var url = Constants.pokedexApiUrlWithOffsetandLimit;
    var decodedJson = jsonDecode(response.body);
    var results = decodedJson["results"];
    url = decodedJson["next"];

    var pokemonResults = List.from(results)
        .map((pokemonResult) => PokemonResult.fromMap(pokemonResult))
        .toList();

    var pokemons = <Tuple2<Pokemon, int>>[];

    for (var i = 0; i < pokemonResults.length; i++) {
      var pokemon = await getPokemonData(pokemonResults[i].url);

      // ignore: unnecessary_null_comparison
      if (pokemon == null) {
        throw Exception(
            'Failed to get data for pokemon: ${pokemonResults[i].url}');
      }
      pokemons.add(Tuple2(pokemon, i));
    }
    return pokemons;
  }

  Future<Pokemon> getPokemonByName(String pokemonName) async {
    final urlToSearchPokemonByName = "${Constants.pokedexApiUrl}$pokemonName";
    var response = await client.get(Uri.parse(urlToSearchPokemonByName));
    if (response.statusCode != 200) {
      throw Exception('Failed to get pokemon data: ${response.statusCode}');
    }

    var decodedJson = jsonDecode(response.body);

    return Pokemon.fromMap(decodedJson);
  }

  Future<Pokemon> getPokemonData(String pokemonUrl) async {
    var response = await http.get(Uri.parse(pokemonUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to get pokemon data: ${response.statusCode}');
    }

    var decodedJson = jsonDecode(response.body);

    return Pokemon.fromMap(decodedJson);
  }
}

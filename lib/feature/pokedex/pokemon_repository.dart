import 'dart:convert';

import 'package:pokedex/feature/models/pokemon.dart';
import 'package:pokedex/feature/models/pokemon_result.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
  List<Pokemon> pokemons = [];
  String url = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=20";

  fetchPokemons() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch pokemons: ${response.statusCode}');
    }

    var decodedJson = jsonDecode(response.body);
    var results = decodedJson["results"];
    url = decodedJson["next"];

    var pokemonResults = List.from(results)
        .map((pokemonResult) => PokemonResult.fromMap(pokemonResult))
        .toList();

    var pokemons = <Pokemon>[];

    for (var result in pokemonResults) {
      var pokemon = await getPokemonData(result.url);
      // ignore: unnecessary_null_comparison
      if (pokemon == null) {
        throw Exception('Failed to get data for pokemon: ${result.url}');
      }
      pokemons.add(pokemon);
    }

    pokemons.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));

    return pokemons;
  }

  Future<Pokemon> getPokemonByName(String pokemonName) async {
    final urlToSearchPokemonByName =
        "https://pokeapi.co/api/v2/pokemon/$pokemonName";
    var response = await http.get(Uri.parse(urlToSearchPokemonByName));
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

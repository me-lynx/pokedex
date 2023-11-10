import 'dart:convert';

import 'package:pokedex/feature/models/pokemon_model.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
  final String baseUrl = 'https://pokeapi.co/api/v2/pokemon/?limit=60';

  Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List pokemonsJson = jsonDecode(response.body)['results'];

      return pokemonsJson.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
    } else {
      throw Exception('Failed to load Pokemons');
    }
  }

  Future<Pokemon> getPokemonInfo(String pokemonName) async {
    final String baseUrl = 'https://pokeapi.co/api/v2/pokemon/?$pokemonName';
    final response = await http.get(Uri.parse(baseUrl));
    final pokemonJson = jsonDecode(response.body)['results'];
    return pokemonJson.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
  }
}

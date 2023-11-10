import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_event.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_state.dart';
import 'package:pokedex/feature/models/pokemon_model.dart';
import 'package:pokedex/feature/pokedex/pokemon_repository.dart';

class PokemonInfoPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonInfoPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(pokemon.name.toUpperCase())),
    );
  }
}

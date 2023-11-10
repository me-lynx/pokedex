import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_event.dart';
import 'package:pokedex/feature/pokedex/pokemon_page.dart';
import 'package:pokedex/feature/pokedex/pokemon_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My pokedex',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: BlocProvider(
        create: (context) =>
            PokemonBloc(PokemonRepository())..add(FetchPokemons()),
        child: const PokemonPage(),
      ),
    );
  }
}

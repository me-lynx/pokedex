import 'package:flutter/material.dart';
import 'package:pokedex/constants.dart';
import 'package:pokedex/feature/models/pokemon.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/feature/models/pokemon_result.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_event.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_state.dart';
import 'package:pokedex/feature/pokedex/pokemon_repository.dart';
import 'package:pokedex/main.dart';

class PokemonInfoPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonInfoPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonRepository = getIt<PokemonRepository>();
    return BlocProvider<PokemonInfoBloc>(
      create: (context) {
        return PokemonInfoBloc(pokemonRepository)
          ..add(LoadPokemonInfo(pokemon.name));
      },
      child: BlocBuilder<PokemonInfoBloc, PokemonInfoState>(
        builder: (context, state) {
          if (state is PokemonInfoLoading) {
            return const Center(
                child:
                    Scaffold(body: Center(child: CircularProgressIndicator())));
          } else if (state is PokemonInfoLoaded) {
            return Content(result: state.pokemon);
          } else if (state is PokemonInfoError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class Content extends StatefulWidget {
  Pokemon result;
  Content({required this.result});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final pokemonRepository = getIt<PokemonRepository>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: pokemonTypeMap[widget.result.types[0].types],
        body: Stack(
          children: [
            Positioned(
              top: 20,
              left: 1,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              right: 0,
              child: Text(
                widget.result.name.toUpperCase(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: height * 0.6,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
              ),
            ),
            Positioned(
              top: 100,
              left: width * 0.2,
              height: 200,
              child: Image.network(
                widget.result.imageUrl,
                fit: BoxFit.fitHeight,
              ),
            )
          ],
        ));
  }
}

Future<List<Types>> getPokemonTypesfromApi(String pokemonName) async {
  final pokemonRepository = getIt<PokemonRepository>();

  final response = await pokemonRepository.getPokemonData(pokemonName);

  if (response is Pokemon) {
    return response.types;
  } else {
    throw Exception('Failed to load Pokemon types');
  }
}

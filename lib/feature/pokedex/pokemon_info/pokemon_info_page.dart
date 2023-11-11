import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/constants.dart';
import 'package:pokedex/feature/models/pokemon.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/feature/models/pokemon_result.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_event.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_state.dart';
import 'package:pokedex/feature/pokedex/pokemon_repository.dart';
import 'package:pokedex/helpers/string_extension.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/stats_list.dart';

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
              top: height * 0.2,
              left: width * 0.2,
              child: Text(
                widget.result.name.capitalize(),
                style: GoogleFonts.robotoFlex(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      letterSpacing: 1.0),
                ),
              ),
            ),
            Positioned(
              bottom: 1,
              child: Container(
                width: width,
                height: height * 0.6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              color:
                                  pokemonTypeMap[widget.result.types[0].types]!
                                      .withOpacity(0.4),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  widget.result.types[0].types.capitalize(),
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        letterSpacing: .6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              color:
                                  pokemonTypeMap[widget.result.types[0].types]!
                                      .withOpacity(0.2),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Weight ${widget.result.height.toString()}',
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        letterSpacing: .6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: BaseStatsList(stats: widget.result.stats)),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: width * 0.5,
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

// ignore: camel_case_types
class _buildPokemonType extends StatelessWidget {
  const _buildPokemonType({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Hero(
                tag: pokemon.toString() + pokemon.types[0].types,
                child: Text(
                  pokemon.types[0].types.capitalize(),
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: .6),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

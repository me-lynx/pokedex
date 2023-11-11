import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/modules/pokedex/core/constants/constants.dart';
import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokedex/modules/pokedex/presentation/pages/loading_page.dart';
import 'package:pokedex/modules/pokedex/presentation/pages/pokemon_info_page.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon/pokemon_state.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/search_pokemon/search_pokemon_bloc.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/search_pokemon/search_pokemon_event.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/search_pokemon/search_pokemon_state.dart';
import 'package:pokedex/modules/pokedex/core/utils/string_extension.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<SearchPokemonBloc>(context)
                            .add(SearchUpdated(value));
                      },
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<SearchPokemonBloc, SearchPokemonState>(
                      builder: (context, searchState) {
                        if (searchState is SearchSuccess) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: GridView.builder(
                              itemCount: searchState.pokemons.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return PokeCard(
                                  pokemon: searchState.pokemons[index].item1,
                                  index: searchState.pokemons[index].item2,
                                );
                              },
                            ),
                          );
                        } else if (searchState is SearchFailure) {
                          return Text(searchState.toString());
                        } else {
                          return const LoadingPage();
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: const Color(0xFFF3FCFF),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/pokeball.gif'),
                    Text(
                      loadingPhrases[Random().nextInt(loadingPhrases.length)],
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class PokeCard extends StatelessWidget {
  static const double _pokemonFraction = 0.76;

  final Pokemon pokemon;
  final int index;

  const PokeCard({super.key, required this.pokemon, required this.index});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: pokemonTypeMap[pokemon.types[0].types],
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PokemonInfoPage(
                              pokemon: pokemon,
                            )),
                  );
                },
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildPokemonImage(height: itemHeight, index: index),
                    _buildPokemonName(index: index, pokemon: pokemon),
                    _buildPokemonType(index: index, pokemon: pokemon),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPokemonImage({required double height, required int index}) {
    final pokemonSize = height * _pokemonFraction;

    return Positioned(
      bottom: 2,
      right: 3,
      child: Image.network(
          height: pokemonSize,
          fit: BoxFit.fill,
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${index + 1}.png'),
    );
  }
}

// ignore: camel_case_types
class _buildPokemonType extends StatelessWidget {
  const _buildPokemonType({
    required this.index,
    required this.pokemon,
  });

  final int index;
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
                tag: index.toString() + pokemon.types[0].types,
                child: Text(
                  pokemon.types[0].types.capitalize(),
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontSize: 14,
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

// ignore: camel_case_types
class _buildPokemonName extends StatelessWidget {
  const _buildPokemonName({
    required this.index,
    required this.pokemon,
  });

  final int index;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
        child: Hero(
          tag: index.toString() + pokemon.name,
          child: Text(
            pokemon.name.capitalize(),
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  letterSpacing: .5),
            ),
          ),
        ),
      ),
    );
  }
}

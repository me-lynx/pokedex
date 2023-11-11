import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/constants.dart';
import 'package:pokedex/feature/models/pokemon.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/pokemon_info_page.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_state.dart';
import 'package:pokedex/feature/pokedex/search_pokemon/search_pokemon_bloc.dart';
import 'package:pokedex/feature/pokedex/search_pokemon/search_pokemon_event.dart';
import 'package:pokedex/helpers/string_extension.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pokedex', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pesquisar Pokemon',
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      BlocProvider.of<SearchPokemonBloc>(context)
                          .add(SearchUpdated(value));
                    },
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.pokemons.length ?? 0,
                    itemBuilder: (context, index) {
                      return PokeCard(
                        pokemon: state.pokemons[index],
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is PokemonError) {
            return Text(state.message);
          } else {
            return FutureBuilder(
              future: Future.delayed(const Duration(seconds: 40)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Image.asset('images/pokeball.gif'));
                } else {
                  return Container();
                }
              },
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

  PokeCard({super.key, required this.pokemon, required this.index});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.red, Colors.black],
            ),
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

class _buildPokemonType extends StatelessWidget {
  const _buildPokemonType({
    super.key,
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

class _buildPokemonName extends StatelessWidget {
  const _buildPokemonName({
    super.key,
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

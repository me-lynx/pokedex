import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/constants.dart';
import 'package:pokedex/feature/models/pokemon.dart';
import 'package:pokedex/feature/pokedex/images.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/pokemon_info_page.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_state.dart';

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
                    onChanged: (value) {},
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
  static const double _pokeballFraction = 0.75;
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
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
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
                    _buildPokeballDecoration(height: itemHeight),
                    _buildPokemonImage(height: itemHeight, index: index),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                        child: Hero(
                          tag: index.toString() + pokemon.name,
                          child: Text(
                            pokemon.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              height: 0.7,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPokeballDecoration({required double height}) {
    final pokeballSize = height * _pokeballFraction;

    return Positioned(
      bottom: -height * 0.13,
      right: -height * 0.03,
      child: Image(
        image: AppImages.pokeball,
        width: pokeballSize,
        height: pokeballSize,
        color: Colors.white.withOpacity(0.14),
      ),
    );
  }

  Widget _buildPokemonImage({required double height, required int index}) {
    final pokemonSize = height * _pokemonFraction;

    return Positioned(
      bottom: -2,
      right: 1,
      child: Image.network(
          height: pokemonSize,
          fit: BoxFit.fill,
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${index + 1}.png'),
    );
  }
}

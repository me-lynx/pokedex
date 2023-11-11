import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon/pokemon_event.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon/pokemon_state.dart';
import 'package:pokedex/modules/pokedex/presentation/pages/pokedex_page.dart';
import 'package:mockito/mockito.dart';
import 'package:tuple/tuple.dart';

class MockPokedexBloc extends MockBloc<PokemonEvent, PokemonState>
    implements PokemonBloc {}

void main() {
  late PokemonBloc pokedexBloc;
  List<Tuple2<Pokemon, int>> mockPokemons = [
    Tuple2(
      Pokemon(
        1,
        7,
        'Bulbasaur',
        [
          Stats(name: 'hp', stat: 45),
          Stats(name: 'attack', stat: 49),
          Stats(name: 'defense', stat: 49),
          Stats(name: 'speed', stat: 45),
        ],
        [
          Types(types: 'grass'),
          Types(types: 'poison'),
        ],
        69,
      ),
      1, // Substitua por qualquer int que você queira associar a este Pokemon.
    ),
    Tuple2(
      Pokemon(
        25,
        4,
        'Pikachu',
        [
          Stats(name: 'hp', stat: 35),
          Stats(name: 'attack', stat: 55),
          Stats(name: 'defense', stat: 40),
          Stats(name: 'speed', stat: 90),
        ],
        [
          Types(types: 'electric'),
        ],
        60,
      ),
      2, // Substitua por qualquer int que você queira associar a este Pokemon.
    ),
  ];

  setUp(() {
    pokedexBloc = MockPokedexBloc();
    whenListen(
      pokedexBloc,
      Stream.fromIterable([
        PokemonInitial(),
        PokemonLoaded(mockPokemons),
      ]),
    );
  });

  testWidgets('PokedexPage shows a list of Pokemons',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<PokemonBloc>.value(
        value: pokedexBloc,
        child: const MaterialApp(home: PokedexPage()),
      ),
    );
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(PokeCard), findsNWidgets(mockPokemons.length));
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';
import 'package:pokedex/modules/pokedex/data/repositories/pokemon_repository.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon_info/pokemon_info_bloc.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon_info/pokemon_info_event.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon_info/pokemon_info_state.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  getIt.registerSingleton<PokemonRepository>(PokemonRepository());

  group('PokemonInfoBloc', () {
    final mockPokemonRepository = MockPokemonRepository();
    final pikachu = Pokemon(
      25,
      4,
      'pikachu',
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
    );
  });

  blocTest<PokemonInfoBloc, PokemonInfoState>(
    'emits [PokemonInfoLoading] when LoadPokemonInfo is added',
    build: () => PokemonInfoBloc(),
    act: (bloc) => bloc.add(LoadPokemonInfo('pikachu')),
    expect: () => [
      isA<PokemonInfoLoading>(),
    ],
  );
}

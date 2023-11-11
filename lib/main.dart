import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon/pokemon_event.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/pokemon_info/pokemon_info_bloc.dart';
import 'package:pokedex/modules/pokedex/presentation/pages/pokedex_page.dart';
import 'package:pokedex/modules/pokedex/data/repositories/pokemon_repository.dart';
import 'package:pokedex/modules/pokedex/presentation/blocs/search_pokemon/search_pokemon_bloc.dart';
import 'package:pokedex/modules/pokedex/core/utils/simple_bloc_observer.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<PokemonRepository>(PokemonRepository());
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<PokemonBloc>(
              create: (context) =>
                  PokemonBloc(PokemonRepository())..add(FetchPokemons()),
            ),
            BlocProvider<PokemonInfoBloc>(
                create: (context) => PokemonInfoBloc()),
            BlocProvider(
              create: (context) => SearchPokemonBloc(
                  pokemonBloc: BlocProvider.of<PokemonBloc>(context)),
            ),
          ],
          child: const PokedexPage(),
        ));
  }
}

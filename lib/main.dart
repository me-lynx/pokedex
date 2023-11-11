import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon/bloc/pokemon_event.dart';
import 'package:pokedex/feature/pokedex/pokemon_info/bloc/pokemon_info_bloc.dart';
import 'package:pokedex/feature/pokedex/pokemon_page.dart';
import 'package:pokedex/feature/pokedex/pokemon_repository.dart';
import 'package:pokedex/helpers/simple_bloc_observer.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<PokemonRepository>(PokemonRepository());
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  setup();
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
        home: MultiBlocProvider(
          providers: [
            BlocProvider<PokemonBloc>(
              create: (context) =>
                  PokemonBloc(PokemonRepository())..add(FetchPokemons()),
            ),
            BlocProvider<PokemonInfoBloc>(
              create: (context) =>
                  PokemonInfoBloc(context.read<PokemonRepository>()),
            ),
          ],
          child: const PokemonPage(),
        ));
  }
}

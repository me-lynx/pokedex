import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();
}

class FetchPokemons extends PokemonEvent {
  @override
  List<Object> get props => [];
}

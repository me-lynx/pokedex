abstract class SearchPokemonEvent {}

class SearchUpdated extends SearchPokemonEvent {
  final String query;

  SearchUpdated(this.query);
}

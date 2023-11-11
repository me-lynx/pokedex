import 'dart:ui';

class Constants {
  static Color creamColor = const Color(0xfff5f5f5);
  static const pokedexApiUrl = "https://pokeapi.co/api/v2/pokemon/";
  static const pokedexApiUrlWithOffsetandLimit =
      "https://pokeapi.co/api/v2/pokemon?offset=0&limit=100";
}

const Map<String, Color> pokemonTypeMap = {
  "grass": Color(0xFF78C850),
  "poison": Color(0xFF98558e),
  "fire": Color(0xFFFB6C6C),
  "flying": Color(0xFFA890F0),
  "bug": Color(0xFF48D0B0),
  "water": Color(0xFF7AC7FF),
  "normal": Color(0xFFbcbcad),
  "ground": Color(0xFFeece5a),
  "fairy": Color(0xFFf9acff),
  "electric": Color(0xFFfee53c),
  "fighting": Color(0xFFa75544),
  "psychic": Color(0xFFf160aa),
  "rock": Color(0xFFcebd74),
  "steel": Color(0xFFc4c2db),
  "ice": Color(0xFF96f1ff),
  "ghost": Color(0xFF7C538C),
  "dragon": Color(0xD07038F8),
  "dark": Color(0xFF8f6955),
};

Color getBackGroundColor(String type) {
  return pokemonTypeMap[type]!;
}

const List<String> loadingPhrases = [
  "Wait while we're looking for hidden Pikachus...",
  "We're feeding the Snorlaxes, please wait...",
  "Wait while we're training our Charmanders...",
  "We're looking for lost Pokéballs, hold on a moment...",
  "We're evolving our Eevees, please wait...",
  "Wait while we're challenging the Elite Four...",
  "We're capturing Mewtwos, please wait...",
  "We're traveling through Route 1, hold on a moment...",
  "We're trading our Pokémons, please wait...",
  "We're healing our Pokémons at the Pokémon Center, hold on a moment...",
  "Wait while we're hatching our eggs...",
  "We're surfing with our Lapras, please wait...",
  "Wait while we're exploring the Safari Zone...",
  "We're battling at the Gym, hold on a moment...",
  "We're powering up our Pokémons, please wait...",
  "Wait while we're searching for Legendary Pokémons...",
  "We're training at the Dojo, hold on a moment...",
  "We're visiting Professor Oak, please wait...",
  "Wait while we're collecting Gym Badges...",
  "We're exploring the Pokémon Tower, hold on a moment...",
  "We're catching some Ghost Pokémons, please wait...",
  "Wait while we're exploring the Victory Road...",
  "We're battling Team Rocket, hold on a moment...",
  "We're catching some shiny Pokémons, please wait...",
  "Wait while we're exploring the Pokémon Mansion...",
  "We're battling the Champion, hold on a moment...",
  "We're catching some rare Pokémons, please wait...",
  "Wait while we're exploring the Cerulean Cave...",
  "We're battling the Elite Four, hold on a moment...",
  "We're catching some Legendary Pokémons, please wait..."
];

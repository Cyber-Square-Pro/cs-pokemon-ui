class ApiConstants {
  static String get pokedexSummaryData => "https://pokedex.alansantos.dev/api/pokemons.json";

  static String pokemonDetails(String number) =>
      "https://pokedex.alansantos.dev/api/pokemons/$number.json";

  static String get pokemonItems => "https://pokedex.alansantos.dev/api/items.json";

  static String baseURL = 'https://08c0-2405-201-f00c-3016-51d6-6be7-afef-15dd.ngrok-free.app';
}

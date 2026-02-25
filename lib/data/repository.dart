import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repaso/data/model/pokemon.dart';

class PokemonRepository{
  final String baseUrl = "http://pokeapi.co/api/v2/pokemon";

  Future <Pokemon> getPokemon(String name) async{
    final url = Uri.parse("$baseUrl/${name.toLowerCase()}");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = json.decode(response.body);
      return Pokemon.fromJson(data);
    }

    throw Exception("Pokemon no encontrado");

  }
}
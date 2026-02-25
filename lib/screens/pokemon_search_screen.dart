import 'package:flutter/material.dart';
import '../data/model/pokemon.dart';
import '../data/repository.dart';

class PokemonSearchPage extends StatefulWidget {
  const PokemonSearchPage({super.key});

  @override
  State<PokemonSearchPage> createState() => _PokemonSearchPageState();
}

class _PokemonSearchPageState extends State<PokemonSearchPage> {
  final PokemonRepository _repository = PokemonRepository();

  String _pokemonName = '';
  Future<Pokemon>? _pokemonFuture;

  void _searchPokemon() {
    if (_pokemonName.isEmpty) return;

    setState(() {
      _pokemonFuture = _repository.getPokemon(_pokemonName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscador Pokémon'), centerTitle: true),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Nombre del Pokemon",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _pokemonName = value.trim();
            },
            onFieldSubmitted: (_) => _searchPokemon(),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: _searchPokemon, child: Text("Buscar")),
          SizedBox(height: 20),
          if (_pokemonFuture != null)
            FutureBuilder<Pokemon>(
              future: _pokemonFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                    style: const TextStyle(color: Colors.red),
                  );
                }
                if (snapshot.hasData) {
                  final pokemon = snapshot.data!;
                  return Column(
                    children: [
                      Image.network(pokemon.image, height: 150),
                      SizedBox(height: 10),
                      Text(
                        pokemon.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
        ],
      ),
    );
  }
}

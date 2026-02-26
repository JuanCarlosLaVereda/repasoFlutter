import 'package:flutter/material.dart';
import 'package:repaso/data/model/pokemon.dart';
import '../data/repository.dart';

class PokemonSearchPage extends StatefulWidget {
  final int? edad;
  final String? nombre;
  const PokemonSearchPage({super.key, required this.edad, required this.nombre});

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
      appBar: AppBar(
        title: const Text('Buscador Pokémon'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text ("Hola ${widget.nombre}, tienes ${widget.edad} años"),
          Image.asset("assets/images/pokeball.jpg", height: 25,),
          TextField(
            decoration: InputDecoration(
              labelText: "Nombre del Pokémon",
              border: OutlineInputBorder(),
            ),
            onChanged: (value){
              _pokemonName=value.trim();
            },
          ),
          SizedBox(height: 20,),
          ElevatedButton(
              onPressed:_searchPokemon, child: Text('Buscar')),
          SizedBox(height: 20,),

          if (_pokemonFuture !=null )
            FutureBuilder<Pokemon>(future: _pokemonFuture, builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.red),
                );
              }
              if (snapshot.hasData){
                final pokemon = snapshot.data!;
                return Column(children: [
                  Image.network(pokemon.image, height: 150),
                  SizedBox(height: 10),
                  Text(pokemon.name.toUpperCase(),style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))

                ],);

              }
              return SizedBox();
            })

        ],

      ),

    );


  }
}
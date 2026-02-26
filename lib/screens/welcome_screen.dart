import 'package:flutter/material.dart';
import 'package:repaso/core/app_colors.dart';
import 'package:repaso/screens/pokemon_search_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final nameController = TextEditingController();
  String nombre = "JC";
  double edad = 18;
  late double selectAge;
  late Function(double) onAgeChange;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscador Pokémon'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: AppColors.primary),
          child: Column(
            children: [
              Text("Dime tu nombre", style: TextStyle(fontSize: 10)),
              SizedBox(height: 15),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "nombre",
                ),
              ),
              SizedBox(height: 15),
              Text("Dime tu edad", style: TextStyle(fontSize: 10)),
              SizedBox(height: 15),
              Text(
                'Edad: ${edad.toInt()} años',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Slider(
                value: edad,
                min: 0,
                max: 100,
                divisions: 50,
                label: "${edad.toStringAsFixed(0)} años",
                onChanged: (double value) {
                  setState(() => edad = value);
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokemonSearchPage(
                      nombre: nameController.text,
                      edad: edad.toInt(),
                    ),
                  ),
                );},
                child: Text("Entrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

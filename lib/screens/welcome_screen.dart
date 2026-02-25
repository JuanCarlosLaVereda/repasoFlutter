import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Dime tu nombre", style: TextStyle(fontSize: 10),),
        SizedBox(height: 15,),
        TextField(
          controller: nameController,
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: "nombre"),
        ),
        SizedBox(height: 15,),
        Text("Dime tu edad", style: TextStyle(fontSize: 10),),
        SizedBox(height: 15,),
        Slider(value: widget.selectAge, onChanged: (newAge){
          widget.onAgeChange(newAge);
        },
        min: 0,
        max: 100,
        divisions: 50,
        )

      ],
    );
  }
}

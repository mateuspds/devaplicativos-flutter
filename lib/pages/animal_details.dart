import 'package:flutter/material.dart';

class DelhatlheAnimal extends StatelessWidget {
  Map animal;
   DelhatlheAnimal({Key? key, required this.animal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal['nome']),
      ),
      body: Container(
        child: Column(
          
        ),
      ),
    );
  }
}

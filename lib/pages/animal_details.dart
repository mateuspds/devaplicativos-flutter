import 'package:flutter/material.dart';

class DelhatlheAnimal extends StatelessWidget {
  String url;
  var animal;
  DelhatlheAnimal({Key? key, required this.animal, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal['nome']),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //imagem do animal
            Container(
              width: double.infinity,
              height: 179,
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                animal['nome'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "sexo",
                  style: TextStyle(color: Colors.amber[700], fontSize: 16),
                ),
                Text(
                  "Porte",
                  style: TextStyle(color: Colors.amber[700], fontSize: 16),
                ),
                Text(
                  "Idade",
                  style: TextStyle(color: Colors.amber[700], fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(animal['sexo']),
                Text(animal['porte']),
                Text(animal['idade']),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(7),
              child: Column(
                children: [
                  Text(
                    "localização",
                    style: TextStyle(color: Colors.amber[700], fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(animal['endereco']),
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            //botao pretendo adotar o animal
            Container(
              width: double.infinity,
              color: Colors.amber[700],
              child: TextButton(onPressed: (){}, child: Text('pretendo adotar')))
          ],
        ),
      ),
    );
  }
}

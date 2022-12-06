import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../componentes/textfield.dart';

class Animal extends StatefulWidget {
  const Animal({Key? key}) : super(key: key);

  @override
  _AnimalState createState() => _AnimalState();
}

class _AnimalState extends State<Animal> {
  @override
  Widget build(BuildContext context) {
  FirebaseFirestore.instance.collection("Usuarios");

  final TextEditingController tipoAnimal = TextEditingController();
  final TextEditingController nome = TextEditingController();
  final TextEditingController idade = TextEditingController();
  final TextEditingController sexo = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "CADASTRO Animal ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25),
                  ),
                ),
                 CustomTextField(
                  nometextedintcontroler: tipoAnimal,
                  teclado: TextInputType.emailAddress,
                  label: "tipo animal",
                  osbscure: false,
                  icon: Icons.email,
                ),
                CustomTextField(
                  nometextedintcontroler: nome,
                  teclado: TextInputType.name,
                  label: "nome",
                  icon: Icons.person,
                ),
                CustomTextField(
                  nometextedintcontroler: idade,
                  teclado: TextInputType.number,
                  label: "idade",
                  osbscure: false,
                  icon: Icons.person_pin,
                ),
               
                CustomTextField(
                  nometextedintcontroler: sexo,
                  teclado: TextInputType.emailAddress,
                  label: "sexo",
                  osbscure: true,
                  icon: Icons.password,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(10),
                          textStyle: const TextStyle(fontSize: 22)),
                      onPressed: (){},
                      child: const Text("Cadastrar"),
                    ),
                  ),
                ),
                //voltar usuario
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(10),
                          textStyle: const TextStyle(fontSize: 22)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Voltar"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

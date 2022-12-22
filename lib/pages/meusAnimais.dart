import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Meuanimais extends StatefulWidget {
  const Meuanimais({Key? key}) : super(key: key);

  @override
  State<Meuanimais> createState() => _MeuanimaisState();
}

class _MeuanimaisState extends State<Meuanimais> {
  CollectionReference animais =
      FirebaseFirestore.instance.collection("Animais");
  void listaanimais() {
    FirebaseFirestore.instance
        .collection("Animais")
        .where('idade')
        .get()
        .then((value) => print(value.metadata));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listaanimais();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}

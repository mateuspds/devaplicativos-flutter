import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devapp/model/animal_model.dart';
import 'package:devapp/pages/animal_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Functon/functios.dart';

class Meuanimais extends StatefulWidget {
  final BuildContext context;
  const Meuanimais({Key? key, required this.context}) : super(key: key);

  @override
  State<Meuanimais> createState() => _MeuanimaisState();
}

class _MeuanimaisState extends State<Meuanimais> {
  late Future dados;
  CollectionReference animais =
      FirebaseFirestore.instance.collection("Animais");
  listaanimais(BuildContext context) async {
    // return FirebaseFirestore.instance
    //     .collection("Animais")
    //     .where('dono', isEqualTo: context)
    //     .get();
    String id = Provider.of<Usuario>(context).idUsuario!;
    List<AnimalModel> animais = [];
    final listaAnimal =
        await FirebaseFirestore.instance.collection('Animais').get();
    listaAnimal.docs.forEach((e) {
      AnimalModel animal = AnimalModel.fromMap(e.data());
      if (animal.dono == id) {
        animais.add(animal);
      }
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   dados = listaanimais(widget.context);
  // }

  Stream<QuerySnapshot> _getList() {
    String id = Provider.of<Usuario>(context).idUsuario!;
    return FirebaseFirestore.instance
        .collection('Animais')
        .where('dono', isEqualTo: id)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _getList(),
          builder: (_, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    final DocumentSnapshot doc = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(
                        doc['nome'],
                      ),
                      subtitle: Text('Descrição'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnimalDetails(index)));
                      },
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

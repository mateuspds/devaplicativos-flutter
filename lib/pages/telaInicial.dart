import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devapp/routes/rotas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/imageUrl.dart';
import 'animal_details.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _MyAnimalsScreenState();
}

class _MyAnimalsScreenState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final Storage storage = Storage();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(child: Text("MENU")),
            ),
            ListTile(
              leading: const Icon(Icons.app_registration_outlined),
              title: const Text("cadastrar animal"),
              onTap: () {
                Navigator.of(context).pushNamed(Rotas.cadastroAnimal);
              },
            ),
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text("meus animais"),
              onTap: () {
                Navigator.of(context).pushNamed(Rotas.meusAnimais);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Adoção",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Animais")
                  .where("doacao", isEqualTo: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Column(
                          children: [
                            //enter
                            const SizedBox(height: 20),
                            Container(
                              width: 344,
                              height: 290,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Container(
                                    color: Colors.amber,
                                    height: 35,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const SizedBox(width: 10),
                                        Text(
                                          snap[index]['nome'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color:
                                                Color.fromARGB(255, 67, 67, 67),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.favorite),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: storage
                                          .downloadURL(snap[index]['id']),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData) {
                                          return Container(
                                            width: 344,
                                            height: 183,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        snapshot.data!),
                                                    fit: BoxFit.cover)),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DelhatlheAnimal(
                                                              url: snapshot.data!,
                                                              animal: snap[index],
                                                            )));
                                              }),
                                            ),
                                          );
                                        }

                                        return const SizedBox(
                                            width: 344,
                                            height: 183,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ));
                                      }),

                                  ///
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(snap[index]['sexo'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(snap[index]['idade'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(snap[index]['porte'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snap[index]['endereco'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),

                                  ///
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

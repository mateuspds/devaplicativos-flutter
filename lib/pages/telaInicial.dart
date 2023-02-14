import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devapp/Functon/functios.dart';
import 'package:devapp/routes/rotas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/imageUrl.dart';
import 'animal_details.dart';
import 'homeChat.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _MyAnimalsScreenState();
}

class _MyAnimalsScreenState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
//

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

//

    final email = Provider.of<Usuario>(context);
    final Storage storage = Storage();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Usuarios")
                          .where("email", isEqualTo: email.email)
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
                              return Column(
                                children: [
                                  FutureBuilder(
                                      future: storage.downloadURL(
                                          snap[index]['foto'], 'Usuario'),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData) {
                                          return Container(
                                            width: 144,
                                            height: 90,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        snapshot.data!),
                                                    fit: BoxFit.cover)),
                                          );
                                        }

                                        return Container();
                                      }),
                                  SizedBox(height: 5),
                                  Text(snap[index]['nome'])
                                ],
                              );
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                )),
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
            ),
            //

            ListTile(
              leading: const Icon(Icons.chat),
              title: Text('Chat'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeChatScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () {
                Navigator.of(context).pushNamed(Rotas.home);
              },
            ),
            // ExpansionTile(
            //   leading: const Icon(Icons.pets),
            //   title: const Text('Atalhos'),
            //   textColor: const Color.fromARGB(255, 67, 67, 67),
            //   collapsedBackgroundColor: const Color.fromARGB(255, 254, 226, 155),
            //   //backgroundColor: const Color.fromARGB(255, 254, 226, 155),
            //   trailing: Icon(
            //     _customTileExpanded
            //         ? Icons.arrow_drop_down
            //         : Icons.arrow_drop_down,
            //   ),

            // children: <Widget>[
            //   const Divider(
            //     endIndent: 100,
            //   ),

            //
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
                                    color: Colors.blue,
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
                                      future: storage.downloadURL(
                                          snap[index]['id'], 'Animal'),
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
                                                              url: snapshot
                                                                  .data!,
                                                              animal:
                                                                  snap[index],
                                                              dono: snap[index]
                                                                  ['dono'],
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
            ),
          ],
        ),
      ),
    );
  }
}

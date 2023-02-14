import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/message.dart';
import 'chat.dart';

class Interessados extends StatefulWidget {
  final String id;
  const Interessados({super.key, required this.id});

  @override
  State<Interessados> createState() => _InteressadosState();
}

class _InteressadosState extends State<Interessados> {
  //
  Future<void> pushNotificacao(String token, String mensagem) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAcZeWDRw:APA91bHondAPAnlNrniNHf7J1mTZbs-GwNbDk7fxPMCSCg60uujsIp-UnNMbMEi3VpREJrozq36uPjvJHlwhRXwYmii4zspIrI3BHy4hXyywviWzggewLNHaFUguxWjgy2d3q-b6mSGV',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              //'title': 'alguém pretende adotar o(a) ${widget.name}',
              'body': mensagem,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("erro inesperado");
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;


    //
    return Scaffold(
      appBar: AppBar(
        title: Text("interessados"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('interessados')
                    .where("animalId", isEqualTo: widget.id)
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
                          child: Column(children: [
                            Container(
                              alignment: Alignment.center,
                              width: 200.0,
                              height: 200.0,
                              // decoration: const BoxDecoration(
                              //   shape: BoxShape.circle,
                              //   image: DecorationImage(
                              //     fit: BoxFit.cover,
                              //     image: AssetImage(
                              //         'assets/ImagemTeste/ImagemDePerfil.jpeg'),
                              //   ),
                              // ),
                              child: Material(
                                color: Color.fromARGB(0, 3, 0, 0),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25.0),
                                          ),
                                        ),
                                        builder: (context) {
                                          return SizedBox(
                                            height: 100,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                //
                                                TextButton(
                                                    onPressed: () {},
                                                    child: Text("Doar")),
                                                //
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      FirebaseFirestore.instance
                                                          .collection("Animais")
                                                          .doc(snap[index]
                                                                  ['animalId']
                                                              .replaceAll(
                                                                  ' ', ''))
                                                          .update({
                                                            "dono": snap[index][
                                                                'interessadoId']
                                                          })
                                                          .then((_) =>
                                                              print('Success'))
                                                          .catchError(
                                                            (error) => print(
                                                                'Failed: $error'),
                                                          );
                                                      // FirebaseFirestore.instance
                                                      //     .collection(
                                                      //         "interested")
                                                      //     .where("animalId",
                                                      //         isEqualTo: snap[
                                                      //                     index]
                                                      //                 [
                                                      //                 'animalId']
                                                      //             .replaceAll(
                                                      //                 ' ', ''))
                                                      //     .get()
                                                      //     .
                                                    },
                                                    child: const SizedBox(
                                                      width: double.infinity,
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                          "ACEITAR ADOÇÃO",
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    205,
                                                                    22,
                                                                    22),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      //print(snapshot.data!.docs[index].id);
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              "interessados")
                                                          .doc(snapshot.data!
                                                              .docs[index].id)
                                                          .delete();
                                                    },
                                                    child: const SizedBox(
                                                      width: double.infinity,
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                          "NEGAR ADOÇÃO",
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              snap[index]['interessadoNome'],
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 67, 67, 67),
                              ),
                            ),

                            const SizedBox(height: 12),

                            //deletar solicitação

                            TextButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("interessados")
                                      .doc(snapshot.data!.docs[index].id)
                                      .delete();

                                  const snackBar = SnackBar(
                                    content: Text('solicitação deletada!'),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);

                                  //notificação deletada
                                  await pushNotificacao(
                                      snap[index]['interessadoToken'],
                                      'pedido de adoção negado do animal ${snap[index]['nome']}');

                                  //
                                },
                                child: Text("deletar")),

                            TextButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("Animais")
                                      .doc(snap[index]['animalId']
                                          .replaceAll(' ', ''))
                                      .update({
                                    "dono": snap[index]['interessadoId']
                                  });

                                  //
                                  const snackBar = SnackBar(
                                    content: Text('solicitaçaõ aceita!'),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);

                                  //notificação deletada
                                  await pushNotificacao(
                                      snap[index]['interessadoToken'],
                                      'pedido de adoção aceito do animal ${snap[index]['nome']}');

                                  //

                                  await FirebaseFirestore.instance
                                      .collection("interessados")
                                      .doc(snapshot.data!.docs[index].id)
                                      .delete();
                                },
                                child: Text("aceitar")),


                            TextButton(onPressed: ()async {
                              //
                               
                                 DatabaseService().getGroupUsers('${user?.uid}', snap[index]['interessadoId'])
                                        .then((idGroup) => {
                                          if(idGroup != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ChatScreen(idGroup: '$idGroup', userName: snap[index]['interessadoNome'],),
                                              ),
                                            )
                                          } else {
                                            DatabaseService().createGroup('${user?.uid}', snap[index]['interessadoId'], snap[index]['interessadoNome'])
                                              .then((idGroup) => {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ChatScreen(idGroup: '$idGroup', userName: snap[index]['interessadoNome'],),
                                                  ),
                                                ),
                                              })
                                          }
                                        });
                              





                              //
                            }, child: Text("chat")),

                            //

                            Center(
                              child: Container(
                                width: 232.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 136, 201, 191),
                                  borderRadius: BorderRadius.circular(2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      // DatabaseService().getGroupUsers('${user?.uid}', snap[index]['interestedId'])
                                      //   .then((idGroup) => {
                                      //     if(idGroup != null) {
                                      //       Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //           builder: (context) => ChatScreen(idGroup: '$idGroup', userName: snap[index]['interestedName'],),
                                      //         ),
                                      //       )
                                      //     } else {
                                      //       DatabaseService().createGroup('${user?.uid}', snap[index]['interestedId'], snap[index]['interestedName'])
                                      //         .then((idGroup) => {
                                      //           Navigator.push(
                                      //             context,
                                      //             MaterialPageRoute(
                                      //               builder: (context) => ChatScreen(idGroup: '$idGroup', userName: snap[index]['interestedName'],),
                                      //             ),
                                      //           ),
                                      //         })
                                      //     }
                                      //   });
                                    },

                                    //
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                })
          ],
        ),
      ),
    );
  }
}

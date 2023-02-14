import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devapp/routes/rotas.dart';
import 'package:devapp/services/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DelhatlheAnimal extends StatefulWidget {
  String url;
  String dono;
  var animal;
  DelhatlheAnimal(
      {Key? key, required this.animal, required this.url, required this.dono})
      : super(key: key);

  @override
  State<DelhatlheAnimal> createState() => _DelhatlheAnimalState();
}

class _DelhatlheAnimalState extends State<DelhatlheAnimal> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPeopleInfo();
    getInterestedInfo();
  }

  String? token;
  String? interestedToken;
  String? interestedName;
  CollectionReference animais =
      FirebaseFirestore.instance.collection("Animais");

//
  void getPeopleInfo() async {
    //final User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(widget.dono)
        .get();

    setState(() {
      token = snap['token'];
    });
    print(token);
  }

  void getInterestedInfo() async {
    //final User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(user?.uid)
        .get();

    setState(() {
      interestedToken = snap['token'];
      interestedName = snap['nome'];
    });
  }

//

  Future<void> pushNotificacao(String token) async {
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
              'body': 'alguém pretende adotar ${widget.animal['nome']}',
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

  bool loading = false;
//
  @override
  Widget build(BuildContext context) {
    bool loading = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animal['nome']),
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
                widget.url,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.animal['nome'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "sexo",
                  style: TextStyle(color: Colors.blue[700], fontSize: 16),
                ),
                Text(
                  "Porte",
                  style: TextStyle(color: Colors.blue[700], fontSize: 16),
                ),
                Text(
                  "Idade",
                  style: TextStyle(color: Colors.blue[700], fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(widget.animal['sexo']),
                Text(widget.animal['porte']),
                Text(widget.animal['idade']),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(7),
              child: Column(
                children: [
                  Text(
                    "localização",
                    style: TextStyle(color: Colors.blue[700], fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.animal['endereco']),
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            //botao pretendo adotar o animal
            Container(
              width: double.infinity,
              color: Colors.blue[700],
              child: TextButton(
                onPressed: () async {
                  try {
                    setState(() {
                      loading = true;
                    });
                    await pushNotificacao(token!);
                    // await Provider.of<NotificationService>(context,
                    //         listen: false)
                    //     .showNotification(
                    //   CustomNotification(
                    //       id: 1,
                    //       title: 'Teste',
                    //       body: 'Animal Adotado',
                    //       payload: Rotas.home,
                    //       token: "hhhh"),
                    // );
                    final User? user = FirebaseAuth.instance.currentUser;
                    var a = await animais.doc(widget.animal.id);
                    var db = FirebaseFirestore.instance;
                    await db.collection('interessados').doc().set({
                      'interessadoId': user?.uid,
                      'interessadoToken': interestedToken,
                      'interessadoNome': interestedName,
                      'animalId': a.id,
                      'nome': widget.animal['nome'],
                    });

                    setState(() {
                      loading = false;
                    });
                  } catch (e) {
                    print("errado");
                  }
                },
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text('Pretendo adotar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

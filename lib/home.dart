import 'dart:async';

import 'package:devapp/componentes/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:devapp/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool logado = false;
    //
    void doLogin(BuildContext context) async {
      try {
        FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text, password: senha.text);
        setState(() {
          logado = true;
        });
      } on FirebaseAuthException catch (e) {
        print(e.toString());
        setState(() {
          logado = false;
        });
      }
    }

    //

    final media = MediaQuery.of(context).size;
    return Scaffold(
        body: Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: media.height * 0.2,
              width: media.width * 0.4,
              child: const Text(
                "Bem vindo ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25),
              ),
            ),
          ),
          CustomTextField(
            nometextedintcontroler: email,
            teclado: TextInputType.emailAddress,
            label: "email",
            icon: Icons.person,
          ),
          CustomTextField(
            nometextedintcontroler: senha,
            teclado: TextInputType.emailAddress,
            label: "senha",
            osbscure: true,
            icon: Icons.password,
          ),
          const SizedBox(height: 20),
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
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    doLogin(context);
                    if (logado) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("login realizado"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("fechar"))
                              ],
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("erro ao realizar o login"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("fechar"))
                              ],
                            );
                          });
                    }
                    setState(() {
                      email.clear();
                      senha.clear();
                    });
                  }
                },
                child: const Text("Login"),
              ),
            ),
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
                onPressed: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()));
                },
                child: const Text("Cadastre-se"),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

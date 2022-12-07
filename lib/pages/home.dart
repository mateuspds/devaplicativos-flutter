import 'dart:async';

import 'package:devapp/Functon/functios.dart';
import 'package:devapp/componentes/textfield.dart';
import 'package:devapp/routes/rotas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:devapp/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    final logado = Provider.of<Usuario>(context, listen: false);

    void usuarioLogado() {
      Navigator.of(context).pushReplacementNamed(Rotas.telaInicial);
    }

    Future<bool> doLogin() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text, password: senha.text);
        logado.usarioLOgado();
        return true;
      } catch (e) {
        return false;
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
                    bool a = await doLogin();
                    if (a) {
                      usuarioLogado();
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("erro ao fazer o login"),
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
                onPressed: () {
                  Navigator.of(context).pushNamed(Rotas.cadastro);
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
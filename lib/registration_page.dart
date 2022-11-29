import 'package:devapp/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'componentes/textfield.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController nome = TextEditingController();
  final TextEditingController idade = TextEditingController();
  final TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
        body: Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: media.height * 0.2,
              width: media.width * 0.4,
              child: const Text(
                "CADASTRO ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25),
              ),
            ),
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
            icon: Icons.person,
          ),
          CustomTextField(
            nometextedintcontroler: email,
            teclado: TextInputType.emailAddress,
            label: "email",
            osbscure: false,
            icon: Icons.person,
          ),
          CustomTextField(
            nometextedintcontroler: senha,
            teclado: TextInputType.emailAddress,
            label: "senha",
            osbscure: true,
            icon: Icons.person,
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
                onPressed: () async {},
                child: const Text("Cadastrar"),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

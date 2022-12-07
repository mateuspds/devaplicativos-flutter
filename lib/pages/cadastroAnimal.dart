import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../componentes/textfield.dart';

class Animal extends StatefulWidget {
  const Animal({Key? key}) : super(key: key);

  @override
  _AnimalState createState() => _AnimalState();
}

class _AnimalState extends State<Animal> {
  bool booltipoanimalca = false;
  bool booltipoanimalga = false;
  TextEditingController nomecontroler = TextEditingController();

  bool boolsexoanimalMA = false;
  bool boolsexoanimalFE = false;

  bool porteGrade = false;
  bool porteMedio = false;
  bool portePequeno = false;
  String tipoAnimal = "";
  String idade = "";
  String sexo = "";
  String porte = "";

  @override
  Widget build(BuildContext context) {
    CollectionReference animais =
        FirebaseFirestore.instance.collection("Animais");

    Future<bool> cadastrarAnimal() async {
      try {
        await animais.add({
          "tipo do animal": tipoAnimal,
          "nome": nomecontroler.text,
          "idade": idade,
          "sexo": sexo,
          "porte":porte,
        });
        return true;
      } catch (e) {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("cadastro do animal"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                " ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,

                ),
                height: 80,
                width: double.infinity,
                child: Center(child: Text("?")),
              ),
            ),

            //nome
            CustomTextField(
                nometextedintcontroler: nomecontroler,
                teclado: TextInputType.name,
                label: "nome",
                icon: Icons.person),
            Text("especie"),
            CheckboxListTile(
                title: Text("cachorro"),
                value: booltipoanimalca,
                onChanged: (value) {
                  setState(() {
                    booltipoanimalca = !booltipoanimalca;
                    tipoAnimal = "cachorro";
                  });
                }),
            CheckboxListTile(
                title: Text("gato"),
                value: booltipoanimalga,
                onChanged: (value) {
                  setState(() {
                    booltipoanimalga = !booltipoanimalga;
                    tipoAnimal = "gato";
                  });
                }),

            Text("sexo"),
            CheckboxListTile(
                title: Text("masculino"),
                value: boolsexoanimalMA,
                onChanged: (value) {
                  setState(() {
                    boolsexoanimalMA = !boolsexoanimalMA;
                    sexo = "masculino";
                  });
                }),
            CheckboxListTile(
                title: Text("feminino"),
                value: boolsexoanimalFE,
                onChanged: (value) {
                  setState(() {
                    boolsexoanimalFE = !boolsexoanimalFE;
                    sexo = "feminino";
                  });
                }),

            Text("porte"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("pequeno"),
                Checkbox(
                    value: portePequeno,
                    onChanged: (value) {
                      setState(() {
                        portePequeno = !portePequeno;
                        porte = "pequeno";
                      });
                    }),
              //medio
               Text("medio"),
                Checkbox(
                    value: porteMedio,
                    onChanged: (value) {
                      setState(() {
                        porteMedio = !porteMedio;
                        porte = "medio";
                      });
                    }),

                 Text("grande"),
                Checkbox(
                    value: porteGrade,
                    onChanged: (value) {
                      setState(() {
                        porteGrade = !porteGrade;
                        porte = "grande";
                      });
                    })
              ],
            ),
            // Checkbox(value: value, onChanged: onChanged)

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
                    bool a = await cadastrarAnimal();
                    if (a) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("cadastro realizado"),
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
                              title: const Text("erro ao criar o animal"),
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
                  },
                  child: const Text("Cadastrar Animal"),
                ),
              ),
            ),
            //voltar usuario
          ],
        ),
      ),
    );
  }
}
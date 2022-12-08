import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devapp/componentes/customToggle.dart';
import 'package:flutter/material.dart';

import '../componentes/textfield.dart';

class Animal extends StatefulWidget {
  const Animal({Key? key}) : super(key: key);

  @override
  _AnimalState createState() => _AnimalState();
}

class _AnimalState extends State<Animal> {
  TextEditingController nomecontroler = TextEditingController();
  String tipoAnimal = "cachorro";
  String idade = "filhote";
  String sexo = "macho";
  String porte = "pequeno";
  List<bool> selectIdadeBool = [true, false, false];
  List<String> selectIdadeString = ["filhote", "adulto", "idoso"];
  List<bool> selectPorte = [true, false, false];
  List<String> selectPorteString = ["pequeno", "medio", "grande"];
  List<bool> _selectSexo = [true, false];
  List<String> selectSexo = ["Macho", "Femea"];
  List<bool> selectEspecieBool = [true, false];
  List<String> selectEspecie = ["Cachorro", "Gato"];

  @override
  Widget build(BuildContext context) {
    //
    //
    CollectionReference animais =
        FirebaseFirestore.instance.collection("Animais");

    Future<bool> cadastrarAnimal() async {
      try {
        await animais.add({
          "nome": nomecontroler.text,
          "tipo do animal": tipoAnimal,
          "idade": idade,
          "sexo": sexo,
          "porte": porte,
        });
        return true;
      } catch (e) {
        return false;
      }
    }

    //fuction de setstate de animal
    void mudarString(int newindex, List<bool> booleano,
        List<String> stringtexto, String mudarstring) {
      setState(() {
        for (int index = 0; index < booleano.length; index++) {
          if (index == newindex) {
            booleano[index] = true;
            mudarstring = stringtexto[newindex];
          } else {
            booleano[index] = false;
          }
        }
      });
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
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                height: 80,
                width: double.infinity,
                child: const Center(child: Text("?")),
              ),
            ),

            //nome
            CustomTextField(
                nometextedintcontroler: nomecontroler,
                teclado: TextInputType.name,
                label: "nome",
                icon: Icons.person),
            const Text("especie"),
            //especie
            CustomTogle(
                FuctionEle: (int newindex) {
                  mudarString(
                      newindex, selectEspecieBool, selectEspecie, tipoAnimal);
                },
                selectTexto: selectEspecie,
                selectBool: selectEspecieBool),

            //sexo do animal
            Text("sexo"),
            CustomTogle(
                FuctionEle: (int newindex) {
                  mudarString(newindex, _selectSexo, selectSexo, sexo);
                },
                selectTexto: selectSexo,
                selectBool: _selectSexo),
            // porte
            const Text("porte"),
            CustomTogle(
                FuctionEle: (int newindex) {
                  mudarString(newindex, selectPorte, selectPorteString, porte);
                },
                selectTexto: selectPorteString,
                selectBool: selectPorte),
            // idade
            const Text("idade"),
            CustomTogle(
                FuctionEle: (int newindex) {
                  mudarString(
                      newindex, selectIdadeBool, selectIdadeString, idade);
                },
                selectTexto: selectIdadeString,
                selectBool: selectIdadeBool),

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
                    try {
                        if (nomecontroler.text.isNotEmpty) {
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
                                        nomecontroler.clear();
                                        Navigator.pop(context);
                                    
                                    },
                                    child: const Text("fechar"))
                              ],
                            );
                          });
                    }
                      
                    }
                      
                    } catch (e) {
                       
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

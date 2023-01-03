import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devapp/Functon/functios.dart';
import 'package:devapp/componentes/radio.dart';
import 'package:devapp/model/animal_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../componentes/textfield.dart';

class Animal extends StatefulWidget {
  const Animal({Key? key}) : super(key: key);

  @override
  _AnimalState createState() => _AnimalState();
}

class _AnimalState extends State<Animal> {
  //
  XFile? img;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image;
  }

  Future getImageGalery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<void> upload(String path, String nomeImage) async {
    File file = File(path);

    try {
      String ref = 'Animal/$nomeImage';
      await storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception("erro ao upload de image");
    }
  }

  mandandoImage(String nome) async {
    if (img != null) {
      await upload(img!.path, nome);
    }
  }

  //

  TextEditingController nomecontroler = TextEditingController();
  String? selecionarSexo;
  String? selecionarEspecie;
  String? porte;
  String? idade;
  bool doacao = false;

  @override
  Widget build(BuildContext context) {
    final providerUsur = Provider.of<Usuario>(context, listen: false);
    CollectionReference animais =
        FirebaseFirestore.instance.collection("Animais");

    Future<bool> cadastrarAnimal() async {
      try {
        AnimalModel animal = AnimalModel(
          tipoDoAnimal: selecionarEspecie!,
          sexo: selecionarSexo!,
          nome: nomecontroler.text,
          idade: idade!,
          porte: porte!,
          dono: providerUsur.idUsuario!,
          doacao: doacao,
        );
        await animais.add(animal.toMap()).then((value) => mandandoImage(value.id));
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
          mainAxisAlignment: MainAxisAlignment.end,
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    XFile? image =
                        await _picker.pickImage(source: ImageSource.camera);
                    setState(() {
                      img = image;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.file_copy_outlined),
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      img = image;
                    });
                  },
                ),
              ],
            ),

            //nome
            CustomTextField(
                nometextedintcontroler: nomecontroler,
                teclado: TextInputType.name,
                label: "nome",
                icon: Icons.person),

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

            //cadastro de animal

            //especie
            Text("Especie"),
            Row(
              children: [
                RadioCustom(
                  selecionar: selecionarEspecie,
                  texto: "cachorro",
                  acao: ((value) {
                    setState(() {
                      selecionarEspecie = value.toString();
                    });
                  }),
                ),
                RadioCustom(
                  selecionar: selecionarEspecie,
                  texto: "gato",
                  acao: ((value) {
                    setState(() {
                      selecionarEspecie = value.toString();
                    });
                  }),
                )
              ],
            ),

            //sexo
            Text("sexo"),
            Row(
              children: [
                RadioCustom(
                    selecionar: selecionarSexo,
                    texto: "macho",
                    acao: (value) {
                      setState(() {
                        selecionarSexo = value.toString();
                      });
                    }),
                RadioCustom(
                    selecionar: selecionarSexo,
                    texto: "Femea",
                    acao: (value) {
                      setState(() {
                        selecionarSexo = value.toString();
                      });
                    }),
              ],
            ),

            //porte
            Text("Porte"),
            Row(
              children: [
                RadioCustom(
                  selecionar: porte,
                  texto: "pequeno",
                  acao: ((value) {
                    setState(() {
                      porte = value.toString();
                    });
                  }),
                ),
                RadioCustom(
                  selecionar: porte,
                  texto: "medio",
                  acao: ((value) {
                    setState(() {
                      porte = value.toString();
                    });
                  }),
                ),
                RadioCustom(
                  selecionar: porte,
                  texto: "grande",
                  acao: ((value) {
                    setState(() {
                      porte = value.toString();
                    });
                  }),
                ),
              ],
            ),
            //idade
            Text("Idade"),
            Row(
              children: [
                RadioCustom(
                  selecionar: idade,
                  texto: "filhote",
                  acao: ((value) {
                    setState(() {
                      idade = value.toString();
                    });
                  }),
                ),
                RadioCustom(
                  selecionar: idade,
                  texto: "adulto",
                  acao: ((value) {
                    setState(() {
                      idade = value.toString();
                    });
                  }),
                ),
                RadioCustom(
                  selecionar: idade,
                  texto: "idoso",
                  acao: ((value) {
                    setState(() {
                      idade = value.toString();
                    });
                  }),
                ),
              ],
            ),

            //doacao
            Text("Doacao"),
            Row(
              children: [
                RadioCustom(
                  selecionar: doacao.toString(),
                  texto: "true",
                  acao: ((value) {
                    setState(() {
                      doacao = true;
                    });
                  }),
                ),
                RadioCustom(
                  selecionar: doacao.toString(),
                  texto: "false",
                  acao: ((value) {
                    setState(() {
                      doacao = false;
                    });
                  }),
                )
              ],
            ),

            //final do cadastro de animal

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

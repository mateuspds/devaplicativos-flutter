import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devapp/Functon/functios.dart';
import 'package:devapp/componentes/radio.dart';
import 'package:devapp/model/animal_model.dart';
import 'package:devapp/routes/rotas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../componentes/textfield.dart';

class Animal extends StatefulWidget {
  const Animal({Key? key}) : super(key: key);

  @override
  _AnimalState createState() => _AnimalState();
}

class _AnimalState extends State<Animal> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

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
  TextEditingController endcontroler = TextEditingController();
  TextEditingController descri = TextEditingController();
  String? selecionarSexo;
  String? selecionarEspecie;
  String? porte;
  String? idade;
  String? tempera;
  String? saude;
  String? necessidade;
  bool doacao = false;
  String idd = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var uuid = const Uuid();
    final uid = uuid.v4();

    CollectionReference animais =
        FirebaseFirestore.instance.collection("Animais");

    Future<bool> cadastrarAnimal() async {
      try {
        setState(() {
          idd = Random().nextDouble().toString();
          loading = true;
        });
        AnimalModel animal = AnimalModel(
          saude: saude!,
          des: descri.text,
          necessidade: necessidade!,
          temperamento: tempera!,
          endereco: endcontroler.text,
          id: idd,
          tipoDoAnimal: selecionarEspecie!,
          sexo: selecionarSexo!,
          nome: nomecontroler.text,
          idade: idade!,
          porte: porte!,
          dono: user!.uid,
          doacao: doacao,
        );
        await animais.add(animal.toMap()).
        then((value) => mandandoImage(idd));
        return true;
      } catch (e) {
        return false;
      } finally {
        setState(() {
          loading = true;
        });
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
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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

                  img == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.camera_alt_outlined),
                              onPressed: () async {
                                final ImagePicker _picker = ImagePicker();
                                XFile? image = await _picker.pickImage(
                                    source: ImageSource.camera);
                                setState(() {
                                  img = image;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.file_copy_outlined),
                              onPressed: () async {
                                final ImagePicker _picker = ImagePicker();
                                XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  img = image;
                                });
                              },
                            ),
                          ],
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(File(img!.path)),
                        ),

                  //nome
                  CustomTextField(
                      nometextedintcontroler: nomecontroler,
                      teclado: TextInputType.name,
                      label: "nome",
                      icon: Icons.person),

                  Padding(padding: const EdgeInsets.all(8.0)),

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
                  Text("temperamento"),
                  // //temperamento
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RadioCustom(
                          selecionar: tempera,
                          texto: 'bricalhao',
                          acao: ((value) {
                            setState(() {
                              tempera = value.toString();
                            });
                          })),
                      RadioCustom(
                          selecionar: tempera,
                          texto: 'timido',
                          acao: ((value) {
                            setState(() {
                              tempera = value.toString();
                            });
                          })),
                      RadioCustom(
                          selecionar: tempera,
                          texto: 'calmo',
                          acao: ((value) {
                            setState(() {
                              tempera = value.toString();
                            });
                          })),
                    ],
                  ),

                  Text("saude"),

                  // //saude
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RadioCustom(
                          selecionar: saude,
                          texto: 'Vacinado',
                          acao: ((value) {
                            setState(() {
                              saude = value.toString();
                            });
                          })),
                      RadioCustom(
                          selecionar: saude,
                          texto: 'doente',
                          acao: ((value) {
                            setState(() {
                              saude = value.toString();
                            });
                          })),
                      RadioCustom(
                          selecionar: saude,
                          texto: 'castrado',
                          acao: ((value) {
                            setState(() {
                              saude = value.toString();
                            });
                          })),
                    ],
                  ),
                  Text("necessidade"),
                  RadioListTile(
                      value: 'Medicamento',
                      groupValue: necessidade,
                      title: Text("medicamento"),
                      onChanged: ((value) {
                        setState(() {
                          necessidade = value.toString();
                        });
                      })),

                  RadioListTile(
                      value: 'auxilio Financeiro',
                      groupValue: necessidade,
                      title: Text("auxilio Financeiro"),
                      onChanged: ((value) {
                        setState(() {
                          necessidade = value.toString();
                        });
                      })),
                  RadioListTile(
                      value: 'alimento',
                      groupValue: necessidade,
                      title: Text("alimento"),
                      onChanged: ((value) {
                        setState(() {
                          necessidade = value.toString();
                        });
                      })),

                  // // necessidade

                  //  RadioCustom(
                  //  selecionar: necessidade,
                  //  texto: 'Alimento',
                  //  acao: ((value) {
                  //    setState(() {
                  //      necessidade = value.toString();
                  //    });
                  //  })),
                  //   RadioCustom(
                  //  selecionar: necessidade,
                  //  texto: 'Auxilio Financeiro',
                  //  acao: ((value) {
                  //    setState(() {
                  //      necessidade = value.toString();
                  //    });
                  //  })),
                  //   RadioCustom(
                  //  selecionar: necessidade,
                  //  texto: 'Medicamento',
                  //  acao: ((value) {
                  //    setState(() {
                  //      necessidade = value.toString();
                  //    });
                  //  })),

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

                  CustomTextField(
                      nometextedintcontroler: endcontroler,
                      teclado: TextInputType.name,
                      label: "endereço",
                      icon: Icons.add_location_alt),

                  CustomTextField(
                      nometextedintcontroler: descri,
                      teclado: TextInputType.name,
                      label: "Sobre o animal",
                      icon: Icons.favorite_outline_outlined),

                  //final do cadastro de animal

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
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
                                                setState(() {
                                                  loading = false;
                                                });
                                                Navigator.restorablePushNamed(
                                                    context, Rotas.telaInicial);
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

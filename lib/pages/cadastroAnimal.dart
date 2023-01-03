
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devapp/Functon/functios.dart';
import 'package:devapp/pages/animal_model.dart';
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
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<Usuario>(context, listen: false);
    final TextEditingController tipoAnimal = TextEditingController();
    final TextEditingController nome = TextEditingController();
    final TextEditingController idade = TextEditingController();
    final TextEditingController sexo = TextEditingController();
    final TextEditingController foto = TextEditingController();
    foto.text = "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";

    final _formKey = GlobalKey<FormState>();

    CollectionReference animais =
        FirebaseFirestore.instance.collection("Animais");
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<XFile?> getImageFromGallery() async {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      return image;
    }

    Future<XFile?> getImageFromCamera() async {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.camera);
      return image;
    }

    pickAnImageFromGallery() async{
      XFile? file = await getImageFromGallery();
      if(file != null){
        List<int> imageBytes = await file.readAsBytes();
        foto.text = base64Encode(imageBytes);
      }


    }
    pickAnImageFromCamera() async{
      XFile? file = await getImageFromCamera();
      if(file != null){
        List<int> imageBytes = await file.readAsBytes();
        foto.text = base64Encode(imageBytes);
      }


    }
    Future<bool> cadastrarAnimal() async {
      AnimalModel animal = AnimalModel(
        tipoAnimal: tipoAnimal.text,
        nome: nome.text,
        idade: idade.text,
        sexo: sexo.text,
        idUsuario: loginProvider.idUsuario!,
        foto: foto.text,
      );
      try {
        await animais.add(animal.toMap());
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
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "CADASTRO Animal ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25),
                  ),
                ),
                Center(child: Row(
                  children: [
                    Image.memory(base64Decode(foto.text),width: 100, height: 100,),
                  ],
                )),
                Center(child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: pickAnImageFromGallery,
                        child: Text("Galeria")
                    ),
                    ElevatedButton(
                        onPressed: pickAnImageFromCamera,
                        child: Text("Camera")
                    ),
                    //Image.memory(base64Decode(foto.text)),
                  ],
                )),
                CustomTextField(
                  nometextedintcontroler: tipoAnimal,
                  teclado: TextInputType.emailAddress,
                  label: "tipo animal",
                  osbscure: false,
                  icon: Icons.email,
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
                  icon: Icons.person_pin,
                ),

                CustomTextField(
                  nometextedintcontroler: sexo,
                  teclado: TextInputType.emailAddress,
                  label: "sexo",
                  //osbscure: false,
                  icon: Icons.password,
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
                        Navigator.of(context).pop();
                      },
                      child: const Text("Voltar"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

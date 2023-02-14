import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devapp/routes/rotas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Functon/functios.dart';
import '../componentes/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
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
      String ref = 'Usuario/$nomeImage';
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

// criar o login e senha e depois logar 
  Future<void> criarSenha(String email, String senha) async{
     await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email, password: senha);
  }
  String? usuario;
 Future<void> logarUsuario()async{
    UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text, password: senha.text);
       setState(() {
         usuario = userCredential.user?.uid;
       });
  }
//

  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController nome = TextEditingController();
  final TextEditingController idade = TextEditingController();
  final TextEditingController senha = TextEditingController();
  String idd = "";
  bool loading = false; 
  @override
  Widget build(BuildContext context) {
    

    void navegao() {
      Navigator.of(context).popAndPushNamed(Rotas.home);
    }

    CollectionReference users =
        FirebaseFirestore.instance.collection("Usuarios");
    Future<bool> cadastrar() async {
      try {
        setState(() {
          idd = Random().nextDouble().toString();
          loading = true;
        });
       final token = await FirebaseMessaging.instance.getToken();
       await criarSenha(email.text, senha.text);
       await logarUsuario();
                users.doc(usuario).set({
                "nome": nome.text,
                "email": email.text,
                "idade": idade.text,
                "senha": senha.text,
                "token": token,
                'foto': idd
              })
            
            .then((value) => mandandoImage(idd));

            

        return true;
      } on FirebaseAuthException catch (e) {
        print(e);
        return false;
      } finally {
        setState(() {
          loading = false;
        });
      }
    }

    return Scaffold(
      body:loading ?const Center(
        child: CircularProgressIndicator(),
      ) : Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "CADASTRO ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25),
                  ),
                ),
                //imagem da pessoa

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

                ///falta colocar

                SizedBox(height: 8),
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
                  nometextedintcontroler: email,
                  teclado: TextInputType.emailAddress,
                  label: "email",
                  osbscure: false,
                  icon: Icons.email,
                ),
                CustomTextField(
                  nometextedintcontroler: senha,
                  teclado: TextInputType.emailAddress,
                  label: "senha",
                  osbscure: true,
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
                        if (_formKey.currentState!.validate()) {
                          bool a = await cadastrar();
                          if (a) {
                               final snackBar = SnackBar(
                           content: const Text('Usuario cadastrado'),
                           backgroundColor: (Colors.black12),
                           action: SnackBarAction(
                             label: 'dismiss',
                             onPressed: () {
                             },
                           ),
                         );
                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            navegao();
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title:
                                        const Text("erro ao criar o usuario"),
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
                      child: const Text("Cadastrar"),
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

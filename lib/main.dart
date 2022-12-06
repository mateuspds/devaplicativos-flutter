
import 'package:devapp/Functon/functios.dart';
import 'package:devapp/pages/cadastroAnimal.dart';
import 'package:devapp/pages/registration_page.dart';
import 'package:devapp/pages/telaInicial.dart';
import 'package:devapp/routes/rotas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Usuario(),
        )
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          Rotas.home:(context) => const Home(),
          Rotas.cadastro:(context) =>const RegistrationPage(),
          Rotas.telaInicial:(context) => const TelaInicial(),
          Rotas.cadastroAnimal:(context) => const Animal()

        },
      ),
    ),
  );
}

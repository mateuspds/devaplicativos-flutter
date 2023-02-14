import 'package:devapp/Functon/functios.dart';
import 'package:devapp/pages/cadastroAnimal.dart';
import 'package:devapp/pages/meusAnimais.dart';
import 'package:devapp/pages/notificationPage.dart';
import 'package:devapp/pages/registration_page.dart';
import 'package:devapp/pages/telaInicial.dart';
import 'package:devapp/routes/rotas.dart';
import 'package:devapp/services/firebase_messaging_service.dart';
import 'package:devapp/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pages/home.dart';

// checkNotifications() async {
//   await Provider.of<NotificationService>(context, listen: false).checkForNotifications();
// }
Future<void> firebaseMsg(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMsg);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Usuario(),
        ),
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
        Provider<FirebaseMessagingService>(
          create: (context) =>
              FirebaseMessagingService(context.read<NotificationService>()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          Rotas.home: (context) => const Home(),
          Rotas.cadastro: (context) => const RegistrationPage(),
          Rotas.telaInicial: (context) => const TelaInicial(),
          Rotas.cadastroAnimal: (context) => const Animal(),
          Rotas.meusAnimais: (context) => const MyAnimalsScreen(),
          Rotas.notications: (context) => const NotificationPage()
        },
      ),
    ),
  );
}

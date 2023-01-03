import 'package:devapp/routes/rotas.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const IconData pets = IconData(0xe4a1, fontFamily: 'MaterialIcons');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ADOTE!",
          textAlign: TextAlign.center,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(child: Text("MENU")),
            ),
            ListTile(
              leading: const Icon(Icons.app_registration_outlined),
              title: const Text("cadastrar animal"),
              onTap: () {
                Navigator.of(context).pushNamed(Rotas.cadastroAnimal);
              },
            ),
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text("meus animais"),
              onTap: () {
                Navigator.of(context).pushNamed(Rotas.meusAnimais);
              },
            )
          ],
        ),
      ),
    );
  }
}

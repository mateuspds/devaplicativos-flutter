import 'package:devapp/routes/rotas.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tela inicial"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Center(child: Text("lista de funções")),
            ),
            ListTile(
              leading: Icon(Icons.animation),
              title: Text("cadastrar animal"),
              onTap: () {
                Navigator.of(context).pushNamed(Rotas.cadastroAnimal);
              },
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class RadioCustom extends StatelessWidget {
  final String? selecionar;
  final String texto;
  final Function(dynamic value) acao;
  const RadioCustom(
      {Key? key,
      required this.selecionar,
      required this.texto,
      required this.acao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(texto),
          
          value: texto,
          groupValue: selecionar,
          onChanged: acao,
          ),
    );
  }
}

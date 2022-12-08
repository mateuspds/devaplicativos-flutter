import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final List<String> listaString;
  final Function(dynamic value) tentarFunction;
  const CustomRadio({Key? key, required this.listaString, required this.tentarFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ListView(
        children: listaString
            .map((e) => ListTile(
                  title: Text(e),
                  leading: Radio(
                      value: e,
                      groupValue: listaString,
                      onChanged: tentarFunction),
                ))
            .toList(),
      )
    ]);
  }
}
